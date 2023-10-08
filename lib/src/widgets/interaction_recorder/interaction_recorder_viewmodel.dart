import 'dart:async';

import 'package:flutter/material.dart' hide RawKeyEvent;
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/models/active_scroll_metrics.dart';
import 'package:session_mate/src/services/data_masking_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate/src/utils/scroll_applicator.dart';
import 'package:session_mate/src/utils/time_utils.dart';
import 'package:session_mate/src/utils/widget_finder.dart';
import 'package:session_mate/src/widgets/session_mate_route_tracker.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class InteractionRecorderViewModel extends BaseViewModel {
  final log = getLogger('InteractionRecorderViewModel');

  final _sessionService = locator<SessionService>();
  final _widgetFinder = locator<WidgetFinder>();
  final _routeTracker = locator<SessionMateRouteTracker>();
  final _timeUtils = locator<TimeUtils>();
  final _maskService = locator<DataMaskingService>();

  final _scrollApplicator = locator<ScrollApplicator>();

  final _notificationController = StreamController<Notification>.broadcast();

  UIEvent? _activeCommand;
  UIEvent? get activeCommand => _activeCommand;

  ActiveScrollMetrics? _activeScrollEvent;
  ActiveScrollMetrics? get activeScrollEvent => _activeScrollEvent;
  Stopwatch? _scrollTimer;

  Offset? _lastTapPosition;

  late Size currentScreenSize;

  bool get hasLastTapPosition => _lastTapPosition != null;
  Offset? get lastTapPosition => _lastTapPosition;

  TextEditingController? _activeTextEditingController;

  bool _currentScrollStartedByUser = false;

  bool get hasActiveCommand => _activeCommand != null;

  bool get hasActiveTextEditingController =>
      _activeTextEditingController != null;

  List<UIEvent> get uiEvents => _sessionService.uiEvents;

  InteractionRecorderViewModel() {
    _notificationController.stream.listen(handleNotifications);
  }

  void setScreenSize(Size size) {
    currentScreenSize = size;
  }

  void handleNotifications(Notification notification) {
    if (notification is ScrollStartNotification) {
      _currentScrollStartedByUser = notification.dragDetails != null;

      if (_currentScrollStartedByUser) {
        onScrollStart(
          scrollOrigin: notification.dragDetails!.globalPosition,
          startingOffset: notification.metrics.pixels,
          scrollDirection: notification.metrics.axis,
        );
      }
    } else if (notification is ScrollEndNotification) {
      if (_currentScrollStartedByUser) {
        onScrollEnd(endOffset: notification.metrics.pixels);
      }

      _currentScrollStartedByUser = false;
    } else if (notification is KeepAliveNotification) {
      // Potential bug: we are dependent on the keepAlive notification to
      // fire after the tap function has set _lastTapPosition to complete.
      if (hasLastTapPosition) {
        final textField =
            _widgetFinder.getTextFieldAtPosition(position: _lastTapPosition!);

        if (textField != null) {
          final hasAttachedController = textField.controller != null;
          if (hasAttachedController) {
            addInputCommand(
              inputController: textField.controller!,
              screenSize: currentScreenSize,
            );
          } else {
            print('''

🛑 SessionMate ERROR 🛑 

You are trying to record text input that has no controller.
This probably means you are using an example app where this bug would not have
been caught.

To capture text in Flutter and use it in your codebase you need to use a 
TextEditingController. 

''');
          }
        }
      }
    }
  }

  void startCommandRecording({
    required Offset position,
    required InteractionType type,
    required Size screenSize,
  }) {
    print('🔴 StartCommandRecording - $position - $type');

    _activeCommand = UIEvent.fromJson({
      "position": EventPosition(
        x: position.dx,
        y: position.dy,
        capturedDeviceHeight: screenSize.height,
        capturedDeviceWidth: screenSize.width,
      ).toJson(),
      "runtimeType": type.name,
    });
  }

  void concludeActiveCommand() {
    if (_activeCommand == null) {
      throw Exception(
        'Trying to conclude a command but none is active. This should not happen',
      );
    }

    if (_activeCommand is InputEvent) {
      _activeCommand = (_activeCommand as InputEvent).copyWith(
        inputData: _maskService
            .stringSubstitution(_activeTextEditingController?.text ?? ''),
        view: _routeTracker.currentRoute,
        order: _timeUtils.timestamp,
      );
    }

    print('🔴 ConcludeCommand - ${_activeCommand?.toJson()}');

    _sessionService.addEvent(_activeCommand!);
  }

  void _clearActiveCommand() {
    _activeCommand = null;
    _activeTextEditingController = null;
  }

  void onUserTap({
    required Offset position,
    required Size screenSize,
  }) {
    if (hasActiveCommand) {
      concludeAndClear();
    }

    print('🔴 Add tap event - $position');

    final scrollables = _widgetFinder.getAllScrollablesOnScreen();

    var rawTapEvent = TapEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      position: EventPosition(
        x: position.dx,
        y: position.dy,
        capturedDeviceWidth: screenSize.width,
        capturedDeviceHeight: screenSize.height,
      ),
      view: _routeTracker.currentRoute,
      order: _timeUtils.timestamp,
    );

    final tapEventWithScrollApplied = _scrollApplicator.applyScrollableToEvent(
      scrollables,
      rawTapEvent,
    );

    _sessionService.addEvent(tapEventWithScrollApplied);

    _lastTapPosition = position;
  }

  void addInputCommand({
    required TextEditingController inputController,
    required Size screenSize,
  }) {
    print('🔴 startRecording input command @ $_lastTapPosition ');

    _activeTextEditingController = inputController;

    if (hasLastTapPosition) {
      if (hasActiveCommand) {
        concludeAndClear();
      }

      startCommandRecording(
          position: _lastTapPosition!,
          type: InteractionType.input,
          screenSize: screenSize);
    } else {
      print(
        '🛑 SessionMate 🛑: An input command should not fire before a tap command, something is broken in Flutter.',
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
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        keyId: keyId,
        keyLabel: keyLabel,
        usbHidUsage: usbHidUsage,
        view: _routeTracker.currentRoute,
        order: _timeUtils.timestamp,
      ),
    );
  }

  void concludeAndClear() {
    concludeActiveCommand();
    _clearActiveCommand();
  }

  bool onChildNotification(Notification notification) {
    _notificationController.add(notification);
    return false;
  }

  void onScrollStart({
    required Offset scrollOrigin,
    required double startingOffset,
    required Axis scrollDirection,
  }) {
    if (hasActiveCommand) {
      concludeAndClear();
    }

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
          id: DateTime.now().millisecondsSinceEpoch.toString(),
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
          view: _routeTracker.currentRoute,
          order: _timeUtils.timestamp,
        ),
      );

      _scrollTimer?.stop();
      _scrollTimer = null;
    }
  }
}
