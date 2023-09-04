import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/services/data_masking_service.dart';
import 'package:session_mate/src/services/session_replay_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

class InterceptorService {
  final _logger = getLogger('InterceptorService');
  final _sessionService = locator<SessionService>();
  final _sessionReplayService = locator<SessionReplayService>();
  final _dataMaskingService = locator<DataMaskingService>();

  final List<String> _nonHashableEvents = [];

  Future<void> onEvent(NetworkEvent event) async {
    if (kRecordUserInteractions) {
      _sessionService.addEvent(_mask(event));
      return;
    }

    _sessionReplayService.handleEvent(event);
  }

  NetworkEvent _mask(NetworkEvent event) {
    if (event is RequestEvent) {
      if (event.url.contains('content')) {
        _nonHashableEvents.add(event.uid);
      }

      return event;
    }

    if (_nonHashableEvents.contains((event as ResponseEvent).uid)) {
      return event;
    }

    return ResponseEvent.fromJson(
      _dataMaskingService.handle((event).toJson()),
    );
  }
}
