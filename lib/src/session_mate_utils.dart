import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/hive_storage_service.dart';
import 'package:session_mate/src/services/session_service.dart';

class SessionMateUtils {
  static void saveSession() {
    final sessionService = locator<SessionService>();
    final localStorageService = locator<HiveStorageService>();

    localStorageService.saveSession(sessionService.captureSession());
  }
}
