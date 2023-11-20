import 'package:catcher_2/catcher_2.dart';
import 'package:catcher_2/model/platform_type.dart';
import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';

class SessionMateHandler extends ReportHandler {
  @override
  List<PlatformType> getSupportedPlatforms() => PlatformType.values;

  @override
  Future<bool> handle(Report report, BuildContext? context) {
    print('🛑🛑🛑🛑🛑🛑🛑🛑 SessionMateHandler 🛑🛑🛑🛑🛑🛑🛑🛑 save session');

    SessionMateUtils.saveSession(
      exception: report.error,
      stackTrace: report.stackTrace,
    );

    return Future.value(true);
  }
}
