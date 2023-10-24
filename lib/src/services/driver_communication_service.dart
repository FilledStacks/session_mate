import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

enum _DriverCommunicationState { waitForReplay, replayActive, freshStart }

class DriverCommunicationService with ListenableServiceMixin {
  final _sessionService = locator<SessionService>();

  Completer<String>? _communicationCompleter;

  final _interactionStreamController = StreamController<dynamic>.broadcast();

  Stream<dynamic> get interactionStream => _interactionStreamController.stream;

  _DriverCommunicationState _state = _DriverCommunicationState.freshStart;

  bool get readyToReplay => _state == _DriverCommunicationState.waitForReplay;

  bool _wasReplayExecuted = false;
  bool get wasReplayExecuted => _wasReplayExecuted;

  VoidCallback? _onReplayCompletedCallback;

  void setOnReplayCompletedCallback(VoidCallback callback) {
    _onReplayCompletedCallback = callback;
  }

  Future<String> handleInstruction(String? sweetCoreInstruction) async {
    if (sweetCoreInstruction == null) {
      throw 'Something went wrong, empty instruction received';
    }

    try {
      final instruction = SweetCoreInstruction.fromJson(
        jsonDecode(sweetCoreInstruction),
      );

      switch (instruction.type) {
        case SweetCoreInstructionType.waitForInteractions:
          return await waitForInteractions();
        case SweetCoreInstructionType.prepareInteraction:
          final uiEvent = UIEvent.fromJson(instruction.data);
          return await prepareInteraction(uiEvent);
        default:
          return 'Instruction not recognized';
      }
    } catch (e) {
      print('🔴 Error:${e.toString()}');
      return '';
    }
  }

  Future<String> waitForInteractions() async {
    print('DriverCommunicationService - waitForInteractions');
    _communicationCompleter = Completer<String>();

    if (_wasReplayExecuted) _onReplayCompletedCallback?.call();

    _state = _DriverCommunicationState.waitForReplay;
    _sessionService.clearNavigationStack();
    notifyListeners();

    return _communicationCompleter!.future;
  }

  void sendInteractions({
    required List<UIEvent> interactions,
    String? sessionId = 'active_session',
  }) {
    print('DriverCommunicationService - Send interactions to driver');
    _state = _DriverCommunicationState.replayActive;
    notifyListeners();

    _communicationCompleter?.complete(jsonEncode(PackageInstruction(
      data: {'sessionId': sessionId, 'interactions': interactions},
    )));
    _wasReplayExecuted = true;
  }

  Future<String> prepareInteraction(UIEvent event) async {
    print('DriverCommunicationService - Prepare interaction to driver');

    _interactionStreamController.add(event);

    print('⏰⏰⏰⏰⏰ Wait');
    await Future.delayed(Duration(seconds: 3));
    print('⏰⏰⏰⏰⏰ Wait done');

    return Future.value(jsonEncode(event));
  }
}
