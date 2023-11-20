import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';
import 'package:session_mate/src/utils/session_mate_handler.dart';

class SessionMateCrashMonitor {
  static void monitor(Widget child) {
    Catcher2Options releaseOptions = Catcher2Options(
      SilentReportMode(),
      [
        ConsoleHandler(),
        SessionMateHandler(),
      ],
    );

    Catcher2(
      rootWidget: SessionMate(child: child),
      debugConfig: releaseOptions,
      releaseConfig: releaseOptions,
    );
  }
}
