import 'dart:math';

import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/hive_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

import 'services/http_service.dart';

class SessionMateUtils {
  static void saveSession({
    SessionPriority? priority,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    final sessionService = locator<SessionService>();
    final localStorageService = locator<HiveService>();
    final httpService = locator<HttpService>();

    if (!kRecordUserInteractions) {
      print('🎥 Session not recorded, you are not on a recording session.');
      return;
    }

    try {
      if (kLocalOnlyUsage) {
        localStorageService.saveSession(sessionService.captureSession(
          exception: exception,
          stackTrace: stackTrace,
        ));
      } else {
        httpService.saveSession(
            session: sessionService.captureSession(
          exception: exception,
          stackTrace: stackTrace,
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  static SessionPriority _getRandomPriority() {
    final random = Random();
    return SessionPriority.values.elementAt(random.nextInt(3));
  }
}
