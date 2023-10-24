import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/helpers/crypto_helper.dart';
import 'package:session_mate/src/helpers/logger_helper.dart';
import 'package:session_mate/src/helpers/response_filter_helper.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate_core/session_mate_core.dart';

import 'data_masking_service.dart';
import 'session_service.dart';

class SessionRecordingService {
  final _configurationService = locator<ConfigurationService>();
  final _dataMaskingService = locator<DataMaskingService>();

  final Map<String, String> _requests = {};

  void handleEvent(NetworkEvent event) {
    try {
      if (event is RequestEvent) {
        _requests[event.uid] = hashEvent(event);
        logRequest(event);
        locator<SessionService>().checkForEnterPressed('RequestEvent');
        return;
      }

      ResponseEvent response = (event as ResponseEvent);

      logResponse(response);

      if (_avoidDataMasking(event)) {
        response = response.copyWith(
          uid: _requests[event.uid]!,
          body: _avoidSavingData(event) ? null : event.body,
        );
      } else {
        response = ResponseEvent.fromJson(_dataMaskingService.handle(
          response.copyWith(uid: _requests[event.uid]!).toJson(),
        ));
      }

      locator<SessionService>().addEvent(response);
      _requests.remove(event.uid);
    } catch (e, s) {
      print('🔴 Error:${e.toString()} StackTrace:\n$s');
    }
  }

  bool _avoidDataMasking(ResponseEvent event) {
    if (!_configurationService.dataMaskingEnabled) return true;

    if (hasImageContentType(event)) return true;

    // NOTE: place to add other filters if necessary

    return false;
  }

  bool _avoidSavingData(ResponseEvent event) {
    if (hasImageContentType(event)) return true;

    return false;
  }
}
