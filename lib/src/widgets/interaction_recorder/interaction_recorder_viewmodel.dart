import 'dart:async';

import 'package:flutter/material.dart' hide RawKeyEvent;
import 'package:flutter/scheduler.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/helpers/logger_helper.dart';
import 'package:session_mate/src/models/active_scroll_metrics.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate/src/utils/text_input_recorder.dart';
import 'package:session_mate/src/utils/time_utils.dart';
import 'package:session_mate/src/widgets/session_mate_route_tracker.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class InteractionRecorderViewModel extends BaseViewModel {
  final _sessionService = locator<SessionService>();
  final _routeTracker = locator<SessionMateRouteTracker>();
  final _timeUtils = locator<TimeUtils>();
  final _textInputRecorder = locator<TextInputRecorder>();

  final _notificationController = StreamController<Notification>.broadcast();

  UIEvent? _activeCommand;
  UIEvent? get activeCommand => _activeCommand;

  ActiveScrollMetrics? _activeScrollEvent;
  ActiveScrollMetrics? get activeScrollEvent => _activeScrollEvent;
  Stopwatch? _scrollTimer;

  Offset? _lastTapPosition;

  final Size _currentScreenSize;

  bool get hasLastTapPosition => _lastTapPosition != null;
  Offset? get lastTapPosition => _lastTapPosition;

  bool _currentScrollStartedByUser = false;
  bool _actuallyScrolled = false;

  bool get hasActiveCommand => _activeCommand != null;

  List<UIEvent> get uiEvents => _sessionService.uiEvents;

  InteractionRecorderViewModel({Size screenSize = Size.zero})
      : _currentScreenSize = screenSize {
    _notificationController.stream.listen(handleNotifications);

    _routeTracker.onPreNavigation(() {
      logNavigationEvent('========= onPreNavigation ==========\n');
      _saveInputEventsAndRepopulate(source: 'onPreNavigation');
    });

    _routeTracker.addListener(() {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _textInputRecorder.populateCurrentTextInfo();
      });
    });
  }

  void handleNotifications(Notification notification) {
    if (notification is ScrollStartNotification) {
      _currentScrollStartedByUser = notification.dragDetails != null;
      _actuallyScrolled = false;

      if (_currentScrollStartedByUser) {
        onScrollStart(
          scrollOrigin: notification.dragDetails!.globalPosition,
          startingOffset: notification.metrics.pixels,
          scrollDirection: notification.metrics.axis,
        );
      }
    } else if (notification is ScrollEndNotification) {
      if (_currentScrollStartedByUser && _actuallyScrolled) {
        onScrollEnd(endOffset: notification.metrics.pixels);
        _currentScrollStartedByUser = false;
      } else {
        _clearActiveScrollCommand();
      }
    } else if (notification is ScrollUpdateNotification) {
      _actuallyScrolled = true;
    }
  }

  void onUserTap({
    required Offset position,
  }) {
    _saveInputEventsAndRepopulate(source: 'onUserTap');

    logUIEvent('🔴 Add tap event - $position');

    final rawTapEvent = TapEvent(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      position: EventPosition(
        x: position.dx,
        y: position.dy,
        capturedDeviceWidth: _currentScreenSize.width,
        capturedDeviceHeight: _currentScreenSize.height,
      ),
      view: _routeTracker.currentRoute,
      order: _timeUtils.timestamp,
      navigationStackId: _sessionService.navigationStackId,
    );

    _sessionService.addEvent(rawTapEvent);

    _lastTapPosition = position;
  }

  void onRawKeyEvent({required InteractionType type}) {
    logUIEvent('🔴 Add rawKeyEvent $type');

    _sessionService.addEvent(
      UIEvent.rawKeyEvent(
        type: type,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        view: _routeTracker.currentRoute,
        order: _timeUtils.timestamp,
        navigationStackId: _sessionService.navigationStackId,
      ),
    );
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
    logUIEvent(
      '🔴 onScrollStart - origin:$scrollOrigin offsetStart:$startingOffset scrollDirection:$scrollDirection',
    );

    _scrollTimer = Stopwatch()..start();
    _activeScrollEvent = ActiveScrollMetrics(
      scrollDirection: scrollDirection,
      scrollOrigin: scrollOrigin,
      startingOffset: startingOffset,
    );
  }

  void onScrollEnd({required double endOffset}) {
    if (_activeScrollEvent != null) {
      logUIEvent('🔴 onScrollEnd - onScrollEnd:$endOffset');
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
            capturedDeviceHeight: _currentScreenSize.height,
            capturedDeviceWidth: _currentScreenSize.width,
          ),
          duration: _scrollTimer?.elapsedMilliseconds,
          view: _routeTracker.currentRoute,
          order: _timeUtils.timestamp,
          navigationStackId: _sessionService.navigationStackId,
        ),
      );

      _clearActiveScrollCommand();

      _textInputRecorder.clearTextInfo();
      _textInputRecorder.populateCurrentTextInfo();
    }
  }

  void _clearActiveScrollCommand() {
    _scrollTimer?.stop();
    _scrollTimer = null;
    _activeScrollEvent = null;
  }

  void _saveInputEventsAndRepopulate({String? source}) {
    logUIEvent('🔴 Check for Input and clear from $source');
    final inputEventsFromChanges = _textInputRecorder.checkForTextChange();
    _sessionService.addAllEvents(inputEventsFromChanges);

    _textInputRecorder.clearTextInfo();
    _textInputRecorder.populateCurrentTextInfo();
  }
}
