import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/hive_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

class SessionMateUtils {
  static void saveSession({SessionPriority priority = SessionPriority.high}) {
    final sessionService = locator<SessionService>();
    final localStorageService = locator<HiveService>();

    if (!kRecordUserInteractions) {
      print('🎥 Session not recorded, you are not on a recording session.');
      return;
    }

    try {
      localStorageService.saveSession(sessionService.captureSession(
        priority: priority,
      ));
    } catch (e) {
      print(e);
    }
  }
}
