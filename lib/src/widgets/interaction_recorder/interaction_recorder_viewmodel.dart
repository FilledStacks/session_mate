import 'dart:async';

import 'package:flutter/material.dart' hide RawKeyEvent;
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/models/scroll_models.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class InteractionRecorderViewModel extends BaseViewModel {
  final log = getLogger('InteractionRecorderViewModel');

  final _sessionService = locator<SessionService>();

  final _notificationController = StreamController<Notification>.broadcast();

  UIEvent? _activeCommand;
  UIEvent? get activeCommand => _activeCommand;

  ActiveScrollMetrics? _activeScrollEvent;
  ActiveScrollMetrics? get activeScrollEvent => _activeScrollEvent;
  Stopwatch? _scrollTimer;

  Offset? _lastTapPosition;

  bool get hasLastTapPosition => _lastTapPosition != null;
  Offset? get lastTapPosition => _lastTapPosition;

  TextEditingController? _activeTextEditingController;

  int? _activeCommandInitialTimestamp;

  bool get hasActiveCommand => _activeCommand != null;

  bool get hasActiveTextEditingController =>
      _activeTextEditingController != null;

  List<UIEvent> get uiEvents => _sessionService.uiEvents;

  InteractionRecorderViewModel() {
    _notificationController.stream.listen(handleNotifications);
  }

  void handleNotifications(Notification notification) {
    if (notification is ScrollStartNotification) {
      final scrollStartedByUser = notification.dragDetails != null;

      if (scrollStartedByUser) {
        onScrollStart(
          scrollOrigin: notification.dragDetails!.globalPosition,
          startingOffset: notification.metrics.pixels,
          scrollDirection: notification.metrics.axis,
        );
      }
    } else if (notification is ScrollEndNotification) {
      onScrollEnd(endOffset: notification.metrics.pixels);
    }
  }

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

  // TODO (Remove): This is not required for scroll capture anymore
  // Removing this requires unit tests to be updated
  void onMoveStart(Offset position) {
    if (hasActiveCommand) {
      concludeAndClear(position);
    }

    startCommandRecording(position: position, type: InteractionType.scroll);
  }

  // TODO (Remove): This is not required for scroll capture anymore
  // Removing this requires unit tests to be updated
  void onMoveEnd(Offset position) {
    concludeAndClear(position);
  }

  void concludeAndClear(Offset position) {
    concludeActiveCommand(position);
    _clearActiveCommand();
  }

  void onChildNotification(Notification notification) {
    _notificationController.add(notification);
  }

  void onScrollStart({
    required Offset scrollOrigin,
    required double startingOffset,
    required Axis scrollDirection,
  }) {
    print(
        '🔴 onScrollStart - origin:$scrollOrigin offsetStart:$startingOffset scrollDirection:$scrollDirection');
    _scrollTimer = Stopwatch()..start();
    _activeScrollEvent = ActiveScrollMetrics(
      scrollDirection: scrollDirection,
      scrollOrigin: scrollOrigin,
      startingOffset: startingOffset,
    );
  }

  void onScrollEnd({required double endOffset}) {
    if (_activeScrollEvent != null) {
      print('🔴 onScrollEnd - onScrollEnd:$endOffset');
      final scrollIsVertical =
          _activeScrollEvent!.scrollDirection == Axis.vertical;
      _sessionService.addEvent(
        ScrollEvent(
          position: EventPosition(
            x: _activeScrollEvent!.scrollOrigin.dx,
            y: _activeScrollEvent!.scrollOrigin.dy,
          ),
          scrollDelta: EventPosition(
            x: !scrollIsVertical
                ? _activeScrollEvent!.startingOffset - endOffset
                : 0,
            y: scrollIsVertical
                ? _activeScrollEvent!.startingOffset - endOffset
                : 0,
          ),
          duration: _scrollTimer?.elapsedMilliseconds,
        ),
      );

      _scrollTimer?.stop();
      _scrollTimer = null;
    }
  }
}
