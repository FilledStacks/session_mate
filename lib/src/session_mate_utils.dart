import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/configuration_service.dart';
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
    if (!locator<ConfigurationService>().enabled) return;

    if (!kRecordUserInteractions) return;

    final sessionService = locator<SessionService>();
    final localStorageService = locator<HiveService>();
    final httpService = locator<HttpService>();

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
      print('🔴 Error:${e.toString()}');
    }
  }
}
