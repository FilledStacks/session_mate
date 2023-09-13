import 'package:flutter/material.dart' hide RawKeyEvent;
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
  Offset? _lastTapPosition;

  bool get hasLastTapPosition => _lastTapPosition != null;
  Offset? get lastTapPosition => _lastTapPosition!;

  TextEditingController? _activeTextEditingController;

  int? _activeCommandInitialTimestamp;

  bool get hasActiveCommand => _activeCommand != null;

  bool get hasActiveTextEditingController =>
      _activeTextEditingController != null;

  List<UIEvent> get uiEvents => _sessionService.uiEvents;

  void startCommandRecording({
    required Offset position,
    required InteractionType type,
  }) {
    print('🔴 StartCommandRecording - $position - $type');

    _activeCommandInitialTimestamp = DateTime.now().millisecondsSinceEpoch;

    _activeCommand = UIEvent.fromJson({
      "position": EventPosition(x: position.dx, y: position.dy).toJson(),
      "runtimeType": type.name,
    });
  }

  void concludeActiveCommand(Offset position) {
    if (_activeCommand == null) {
      throw Exception(
        'Trying to conclude a command but none is active. This should not happen',
      );
    }

    if (_activeCommand is InputEvent) {
      _activeCommand = (_activeCommand as InputEvent).copyWith(
        inputData: _activeTextEditingController?.text,
      );
    }

    if (_activeCommand is ScrollEvent) {
      _activeCommand = (_activeCommand as ScrollEvent).copyWith(
        scrollDelta: EventPosition(
          x: position.dx - _activeCommand!.position.x,
          y: position.dy - _activeCommand!.position.y,
        ),
        duration: DateTime.now().millisecondsSinceEpoch -
            _activeCommandInitialTimestamp!,
      );
    }

    print('🔴 ConcludeCommand - ${_activeCommand?.toJson()}');

    _sessionService.addEvent(_activeCommand!);
  }

  void _clearActiveCommand() {
    _activeCommand = null;
    _activeTextEditingController = null;
  }

  void onUserTap(Offset position) {
    if (hasActiveCommand) {
      concludeAndClear(_lastTapPosition!);
    }

    print('🔴 Add tap event - $position');

    _sessionService.addEvent(TapEvent(
      position: EventPosition(x: position.dx, y: position.dy),
    ));

    _lastTapPosition = position;
  }

  void addInputCommand({required TextEditingController inputController}) {
    print('🔴 startRecording input command @ $_lastTapPosition ');

    _activeTextEditingController = inputController;

    if (hasLastTapPosition) {
      if (hasActiveCommand) {
        concludeAndClear(_lastTapPosition!);
      }

      startCommandRecording(
        position: _lastTapPosition!,
        type: InteractionType.input,
      );
    } else {
      throw Exception(
        'SessionMate: An input command should not fire before a tap command, something is broken in Flutter.',
      );
    }
  }

  void onScrollEvent(
    Offset position,
    Offset scrollDelta,
  ) {
    // print('postion: $position, scrollDelta: $scrollDelta');
  }

  void onRawKeyEvent({
    required int keyId,
    required String keyLabel,
    required int usbHidUsage,
  }) {
    print('🔴 Add rawKeyEvent - keyLabel:$keyLabel');

    _sessionService.addEvent(
      UIEvent.rawKeyEvent(
        keyId: keyId,
        keyLabel: keyLabel,
        usbHidUsage: usbHidUsage,
      ),
    );
  }

  void onMoveStart(Offset position) {
    if (hasActiveCommand) {
      concludeAndClear(position);
    }

    startCommandRecording(position: position, type: InteractionType.scroll);
  }

  void onMoveEnd(Offset position) {
    concludeAndClear(position);
  }

  void concludeAndClear(Offset position) {
    concludeActiveCommand(position);
    _clearActiveCommand();
  }
}
