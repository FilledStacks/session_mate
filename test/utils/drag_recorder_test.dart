import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/utils/drag_recorder.dart';
import 'package:session_mate_core/session_mate_core.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('DragRecorderTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('Record functionality -', () {
      test(
          'When we start a record and complete event, should get event with correct duration and positions',
          () async {
        final recorer = DragRecorder();

        recorer.startDragRecording(
          position: EventPosition(
            x: 1,
            y: 1,
          ),
        );

        await Future.delayed(const Duration(seconds: 1));

        final result = recorer.completeDragEvent(
          endPosition: EventPosition(
            x: 2,
            y: 2,
          ),
        );

        expect(result.scrollEnd.x, 2);
        expect(result.scrollEnd.y, 2);
        expect(result.duration > 1000, true);
      });

      test('When we start a record and cancel, isRecording should be false',
          () async {
        final recorer = DragRecorder();

        recorer.startDragRecording(
          position: EventPosition(
            x: 1,
            y: 1,
          ),
        );

        recorer.clearDragRecording();

        expect(recorer.isRecording, false);
      });
    });
  });
}
