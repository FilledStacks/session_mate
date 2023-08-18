import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/session_replay_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

class InterceptorService {
  final _sessionService = locator<SessionService>();
  final _sessionReplayService = locator<SessionReplayService>();

  Future<void> onEvent(NetworkEvent event) async {
    if (kRecordUserInteractions) {
      _sessionService.addEvent(event);
      return;
    }

    _sessionReplayService.handleEvent(event);
  }
}
