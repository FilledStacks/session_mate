import 'package:flutter/material.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class InteractionRecorderViewModel extends BaseViewModel {
  final log = getLogger('InteractionRecorderViewModel');

  final _sessionService = locator<SessionService>();

  UIEvent? _activeCommand;
  UIEvent? get activeCommand => _activeCommand;

  TextEditingController? _activeTextEditingController;

  bool get hasActiveCommand => _activeCommand != null;

  bool get hasActiveTextEditingController =>
      _activeTextEditingController != null;

  List<UIEvent> get uiEvents => _sessionService.uiEvents;

  void startCommandRecording({
    required Offset position,
    required InteractionType type,
  }) {
    print('StartCommandRecording - $position - $type');
    _activeCommand = UIEvent(
      position: EventPosition(x: position.dx, y: position.dy),
      type: type,
    );
  }

  void updateActiveCommand({required InteractionType type}) {
    print('UpdateActiveCommand - $type');
    _activeCommand = _activeCommand?.copyWith(type: type);
  }

  void updateInputCommandDetails({
    required TextEditingController inputFieldController,
  }) {
    print('UpdateInputCommand with controller');
    _activeTextEditingController = inputFieldController;
  }

  void concludeActiveCommand() {
    final activeCommandRecordingTextInput =
        _activeCommand?.type == InteractionType.input;

    if (activeCommandRecordingTextInput) {
      _activeCommand = _activeCommand?.copyWith(
        inputData: _activeTextEditingController?.text,
      );
    }

    if (_activeCommand == null) {
      throw Exception(
        'Trying to conclude a command but none is active. This should not happen',
      );
    }

    print('ConcludeCommand - ${_activeCommand?.toJson()}');

    _sessionService.addEvent(_activeCommand!);
  }

  void _clearActiveCommand() {
    _activeCommand = null;
    _activeTextEditingController = null;
  }

  void onUserTap(Offset position) {
    if (hasActiveCommand) {
      concludeAndClear();
    }

    startCommandRecording(position: position, type: InteractionType.tap);
  }

  void onScrollEvent(
    Offset position,
    Offset scrollDelta,
  ) {
    // print('postion: $position, scrollDelta: $scrollDelta');
  }

  void onMoveStart(Offset position) {
    // print('postion: $position');
    startCommandRecording(position: position, type: InteractionType.scrollUp);
  }

  void onMoveEnd(Offset position) {
    concludeAndClear();
  }

  void concludeAndClear() {
    concludeActiveCommand();
    _clearActiveCommand();
  }
}
