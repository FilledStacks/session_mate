import 'dart:async';

import 'package:bookshelf/app/app.bottomsheets.dart';
import 'package:bookshelf/app/app.dialogs.dart';
import 'package:bookshelf/app/app.locator.dart';
import 'package:bookshelf/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';
import 'package:stacked_services/stacked_services.dart';

const _apiKey = bool.hasEnvironment('SESSION_MATE_API_KEY')
    ? String.fromEnvironment('SESSION_MATE_API_KEY')
    : null;

const _logNetworkEvents =
    bool.fromEnvironment('SESSION_MATE_LOG_NETWORK_EVENTS');
const _logRawNetworkEvents =
    bool.fromEnvironment('SESSION_MATE_LOG_RAW_NETWORK_EVENTS');

Future<void> main() async {
  if (!kReplaySession) {
    WidgetsFlutterBinding.ensureInitialized();
  }

  await setupSessionMate();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  SessionMateCrashMonitor.monitor(const MainApp());
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
        apiKey: _apiKey,
        logNetworkEvents: _logNetworkEvents,
        logRawNetworkEvents: _logRawNetworkEvents,
        minimumStartupTime: 6000,
        verboseLogs: true,
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
