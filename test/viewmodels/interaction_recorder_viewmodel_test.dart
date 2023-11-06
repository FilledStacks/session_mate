import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:session_mate/src/widgets/interaction_recorder/interaction_recorder_viewmodel.dart';
import 'package:session_mate_core/session_mate_core.dart';

import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';

InteractionRecorderViewModel _getModel() => InteractionRecorderViewModel();

void main() {
  group('InteractionRecorderViewmodel -', () {
    setUpAll(() => registerServices());

    group('Multiple command recording -', () {
      test(
          'When we scroll, tap, scroll, tap, the commands should be in that order when saved',
          () {
        final sessionService = getAndRegisterSessionService();
        final model = _getModel();

        model.onScrollStart(
          scrollDirection: Axis.vertical,
          scrollOrigin: Offset.zero,
          startingOffset: 0,
        );
        model.onScrollEnd(endOffset: 100);

        model.onUserTap(position: Offset(1, 0));

        model.onScrollStart(
          scrollDirection: Axis.vertical,
          scrollOrigin: Offset.zero,
          startingOffset: 100,
        );
        model.onScrollEnd(endOffset: 200);

        model.onUserTap(position: Offset(0, 1));

        verify(sessionService.addEvent(any)).called(4);
      });
    });

    group('handleNotifications -', () {
      test('On ScrollUpdateNotification, should clear the drag details', () {
        final dragRecorder = getAndRegisterDragRecorder();

        final recorder = _getModel();

        recorder.handleNotifications(MockScrollUpdateNotification());

        verify(dragRecorder.clearDragRecording());
      });
    });

    group('onScrollStart -', () {
      test(
          'When called with offset and start position, should set the activeScrollInteraction equal to the values passed in',
          () {
        final model = _getModel();

        model.onScrollStart(
          scrollOrigin: Offset(-1, 1),
          startingOffset: 100,
          scrollDirection: Axis.vertical,
        );

        expect(model.activeScrollEvent, isNotNull);
        expect(model.activeScrollEvent!.scrollOrigin, Offset(-1, 1));
        expect(model.activeScrollEvent!.scrollDirection, Axis.vertical);
        expect(model.activeScrollEvent!.startingOffset, 100);
      });
    });

    group('onScrollEnd -', () {
      test(
          'When called with startOffset 100, endOffset 200, should have delta of (0,100)',
          () {
        final sessionService = getAndRegisterSessionService();
        final model = _getModel();

        model.onScrollStart(
          scrollOrigin: Offset(0, 1),
          startingOffset: 100,
          scrollDirection: Axis.vertical,
        );

        model.onScrollEnd(endOffset: 200);

        verify(
          sessionService.addEvent(
            ScrollEvent(
              position: EventPosition(x: 0, y: 1),
              scrollDelta: EventPosition(x: 0, y: -100),
              duration: 0,
              id: '',
            ),
          ),
        );
      });

      test('When called with 143ms break, should have duration on 143ms',
          () async {
        final sessionService = getAndRegisterSessionService();
        final model = _getModel();

        model.onScrollStart(
          scrollOrigin: Offset(0, 1),
          startingOffset: 100,
          scrollDirection: Axis.vertical,
        );

        await Future.delayed(Duration(milliseconds: 143));

        model.onScrollEnd(endOffset: 200);

        expect(
          (verify(
            sessionService.addEvent(captureAny),
          ).captured.single as ScrollEvent)
              .duration,
          greaterThan(143),
        );
      });
    });

    group('onDragEnd -', () {
      test('When dragRecorder is NOT recording should NOT do anything', () {
        final dragRecorder = getAndRegisterDragRecorder();
        final model = _getModel();

        model.onDragEnd(Offset(-1, 1));

        verify(dragRecorder.isRecording).called(1);
      });

      test('When dragRecorder is recording should call completeDragEvent', () {
        final dragRecorder = getAndRegisterDragRecorder(isRecording: true);
        final sessionService = getAndRegisterSessionService();
        final model = _getModel();

        model.onDragEnd(Offset(-1, 1));

        verify(dragRecorder.isRecording);
        verify(
          dragRecorder.completeDragEvent(endPosition: anyNamed('endPosition')),
        );
        verify(sessionService.addEvent(any));
      });
    });
  });
}
