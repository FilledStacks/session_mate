import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/helpers/crypto_helper.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate_core/session_mate_core.dart';

import 'data_masking_service.dart';
import 'session_service.dart';

class SessionRecordingService {
  final _logger = getLogger('SessionRecordingService');
  final _dataMaskingService = locator<DataMaskingService>();

  final Map<String, String> _requests = {};

  bool _hasImageContentType(ResponseEvent event) {
    if (!event.headers.containsKey('content-type')) return false;

    if (!(event.headers['content-type']?.contains('image') ?? false)) {
      return false;
    }

    return true;
  }

  void handleEvent(NetworkEvent event) {
    if (event is RequestEvent) {
      _requests[event.uid] = hashEvent(event);
      return;
    }

    ResponseEvent response = (event as ResponseEvent);
    if (_avoidDataMasking(event)) {
      response = response.copyWith(uid: _requests[event.uid]!, body: null);
    } else {
      response = ResponseEvent.fromJson(_dataMaskingService.handle(
        response.copyWith(uid: _requests[event.uid]!).toJson(),
      ));
    }

    locator<SessionService>().addEvent(response);
    _requests.remove(event.uid);
  }

  bool _avoidDataMasking(ResponseEvent event) {
    if (kDisableDataMasking) return true;

    if (_hasImageContentType(event)) return true;

    // check other filters if necessary

    return false;
  }
}
