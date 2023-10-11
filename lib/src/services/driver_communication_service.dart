import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

enum _DriverCommunicationState { waitForReplay, replayActive, freshStart }

class DriverCommunicationService with ListenableServiceMixin {
  final _sessionService = locator<SessionService>();

  Completer<String>? _communicationCompleter;

  _DriverCommunicationState _state = _DriverCommunicationState.freshStart;

  bool get readyToReplay => _state == _DriverCommunicationState.waitForReplay;

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

    _state = _DriverCommunicationState.waitForReplay;
    _sessionService.clearNavigationStack();
    notifyListeners();

    return _communicationCompleter!.future;
  }

  void sendInteractions(List<UIEvent> interactions) {
    print('DriverCommunicationService - Send interactions to driver');
    _state = _DriverCommunicationState.replayActive;
    notifyListeners();

    _communicationCompleter?.complete(jsonEncode(interactions));
    _wasReplayExecuted = true;
  }
}
