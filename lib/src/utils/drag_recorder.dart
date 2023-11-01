import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/helpers/logger_helper.dart';
import 'package:session_mate/src/utils/time_utils.dart';
import 'package:session_mate/src/widgets/session_mate_route_tracker.dart';
import 'package:session_mate_core/session_mate_core.dart';

class DragRecorder {
  final _sessionMateRouteTracker = locator<SessionMateRouteTracker>();

  DragEvent? _activeDrag;
  Stopwatch? _timer;

  bool get isRecording => _activeDrag != null;

  void startDragRecording({required EventPosition position}) {
    logUIEvent('Start drag recording: $position');
    _activeDrag = DragEvent(
      position: position,
      view: _sessionMateRouteTracker.currentRoute,
      startedAt: TimeUtils().timestamp,
    );

    _timer = Stopwatch()..start();
  }

  void clearDragRecording() {
    logUIEvent('Clear drag event');

    _activeDrag = null;
    _timer?.stop();
    _timer = null;
  }

  DragEvent completeDragEvent({required EventPosition endPosition}) {
    if (_activeDrag == null) {
      logUIEvent(
        'A drag event was not started, but we\'re trying to complete one',
      );
      throw Exception('Drag cannot be completed if it was not started.');
    }

    _activeDrag = _activeDrag!.copyWith(
      scrollEnd: endPosition,
      duration: _timer?.elapsedMilliseconds ?? -1,
    );

    logUIEvent(
      'Drag completed in ${_timer?.elapsed.inSeconds} seconds. ',
      event: _activeDrag!,
    );

    return _activeDrag!;
  }
}
