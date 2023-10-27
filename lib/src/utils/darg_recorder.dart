import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/helpers/logger_helper.dart';
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

    final scrollDelta = _activeDrag!.position - endPosition;

    _activeDrag = _activeDrag!.copyWith(
      scrollDelta: scrollDelta,
      duration: _timer?.elapsedMilliseconds ?? -1,
    );

    logUIEvent(
      'Drag completed in ${_timer?.elapsed.inSeconds} seconds. ',
      event: _activeDrag!,
    );

    return _activeDrag!;
  }
}
