import 'dart:async';
import 'dart:convert';

import 'package:session_mate_core/session_mate_core.dart';

class DriverCommunicationService {
  Completer<String>? _communicationCompleter;

  Future<String> waitForInteractions() {
    _communicationCompleter = Completer<String>();

    return _communicationCompleter!.future;
  }

  void sendInteractions(List<UIEvent> interactions) {
    print('DriverCommunicationService - Send interactions to driver');
    _communicationCompleter?.complete(jsonEncode(interactions));
  }
}
