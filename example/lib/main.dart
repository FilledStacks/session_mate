import 'package:bookshelf/app/app.bottomsheets.dart';
import 'package:bookshelf/app/app.dialogs.dart';
import 'package:bookshelf/app/app.locator.dart';
import 'package:bookshelf/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  await setupSessionMate();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
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
      ],
      builder: (context, child) => SessionMate(child: child!),
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
