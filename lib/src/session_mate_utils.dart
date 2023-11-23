import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/helpers/logger_helper.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/hive_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

import 'services/http_service.dart';

class SessionMateUtils {
  static Future<void> saveSession({
    SessionPriority? priority,
    Object? exception,
    StackTrace? stackTrace,
  }) async {
    final sessionService = locator<SessionService>();
    final localStorageService = locator<HiveService>();
    final httpService = locator<HttpService>();

    if (!kRecordSession) {
      logText('We are not recording a user session but a save was requested.');
      return;
    }

    try {
      if (kLocalOnlyUsage) {
        localStorageService.saveSession(sessionService.captureSession(
          exception: exception,
          stackTrace: stackTrace,
        ));
      } else {
        await httpService.saveSession(
          session: sessionService.captureSession(
            exception: exception,
            stackTrace: stackTrace,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
