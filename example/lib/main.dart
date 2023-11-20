import 'dart:async';

import 'package:bookshelf/app/app.bottomsheets.dart';
import 'package:bookshelf/app/app.dialogs.dart';
import 'package:bookshelf/app/app.locator.dart';
import 'package:bookshelf/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';
import 'package:stacked_services/stacked_services.dart';

const String? apiKey =
    bool.hasEnvironment('API_KEY') ? String.fromEnvironment('API_KEY') : null;

Future<void> main() async {
  if (!kReplaySession) {
    WidgetsFlutterBinding.ensureInitialized();
  }

  await setupSessionMate();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  await runZonedGuarded(() async {
    FlutterError.onError = handleErrors;

    runApp(const SessionMate(child: MainApp()));
  }, (error, stack) {
    print('🛑🛑🛑🛑🛑🛑 Error Zoned - Save session 🛑🛑🛑🛑🛑🛑');
    SessionMateUtils.saveSession(
      exception: error,
      stackTrace: stack,
    );
  });
}

void handleErrors(FlutterErrorDetails? errorDetails) {
  print('🛑🛑🛑🛑🛑🛑 Error Flutter - Save session 🛑🛑🛑🛑🛑🛑');

  SessionMateUtils.saveSession(
    exception: errorDetails?.exception,
    stackTrace: errorDetails?.stack,
  );

  // Here you can add other error handlers like crash lytics
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
        SessionMateNavigatorObserver.instance,
      ],
      builder: (context, child) => SessionMateBuilder(
        apiKey: apiKey,
        minimumStartupTime: 6000,
        child: child!,
      ),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          filled: true,
          fillColor: Color(0xFF232228),
        ),
        scaffoldBackgroundColor: const Color(0xFF13111B),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14),
          displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
