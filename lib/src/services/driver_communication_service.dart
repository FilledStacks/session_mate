import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class DriverCommunicationService with ListenableServiceMixin {
  Completer<String>? _communicationCompleter;
  bool _readyToReplay = false;
  bool get readyToReplay => _readyToReplay;

  bool _wasReplayExecuted = false;
  bool get wasReplayExecuted => _wasReplayExecuted;

  VoidCallback? _onReplayCompletedCallback;

  void setOnReplayCompletedCallback(VoidCallback callback) {
    _onReplayCompletedCallback = callback;
  }

  Future<String> waitForInteractions() {
    print('DriverCommunicationService - waitForInteractions');
    _communicationCompleter = Completer<String>();

    if (_wasReplayExecuted) _onReplayCompletedCallback?.call();

    _readyToReplay = true;
    notifyListeners();

    return _communicationCompleter!.future;
  }

  void sendInteractions(List<UIEvent> interactions) {
    print('DriverCommunicationService - Send interactions to driver');
    _readyToReplay = false;
    notifyListeners();

    _communicationCompleter?.complete(jsonEncode(interactions));
    _wasReplayExecuted = true;
  }
}
