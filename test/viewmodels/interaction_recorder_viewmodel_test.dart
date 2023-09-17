import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:session_mate/src/widgets/interaction_recorder/interaction_recorder_viewmodel.dart';
import 'package:session_mate_core/session_mate_core.dart';

import '../helpers/test_helpers.dart';

InteractionRecorderViewModel _getModel() => InteractionRecorderViewModel();

void main() {
  group('InteractionRecorderViewmodel -', () {
    setUpAll(() => registerServices());

    group('startCommandRecording -', () {
      test('When startCommand is called, hasActiveCommand should be true ', () {
        final model = _getModel();

        model.startCommandRecording(
          position: Offset(1, 0),
          type: InteractionType.tap,
        );

        expect(model.hasActiveCommand, true);
      });
    });

    group('concludeAndClear -', () {
      test('When called, should clear latest active command', () {
        final model = _getModel();

        model.startCommandRecording(
          position: Offset(1, 0),
          type: InteractionType.tap,
        );

        model.concludeAndClear(Offset(1, 0));
        expect(model.hasActiveCommand, false);
      });

      test('When called, should save the active command to the sessionService',
          () {
        final sessionSercice = getAndRegisterSessionService();
        final model = _getModel();

        final event = UIEvent.tap(position: EventPosition(x: 1, y: 0));

        model.startCommandRecording(
          position: Offset(1, 0),
          type: InteractionType.tap,
        );

        model.concludeAndClear(Offset(1, 0));
        verify(sessionSercice.addEvent(event));
      });
    });

    group('Multiple command recording -', () {
      test(
          'When we scroll, tap, scroll, tap, the commands should be in that order when saved',
          () {
        final sessionService = getAndRegisterSessionService();
        final model = _getModel();

        model.onMoveStart(Offset(0, 0));
        model.onMoveEnd(Offset(50, 0));

        model.onUserTap(Offset(1, 0));

        model.onMoveStart(Offset(50, 0));
        model.onMoveEnd(Offset(0, 50));

        model.onUserTap(Offset(0, 1));

        verify(sessionService.addEvent(any)).called(4);
      });
    });

    group('concludeActiveCommand -', () {
      test('When called, should clear activeTextEditingController', () {
        final model = _getModel();

        model.startCommandRecording(
          position: Offset(1, 0),
          type: InteractionType.tap,
        );

        model.concludeActiveCommand(Offset(1, 0));
        expect(model.hasActiveTextEditingController, false);
      });

      test(
          'If startCommand is called with tap, then with scroll, when we conclude, should have 2 events',
          () {
        final sessionService = getAndRegisterSessionService();
        final model = _getModel();

        model.startCommandRecording(
          position: Offset(1, 0),
          type: InteractionType.tap,
        );

        model.onMoveStart(Offset(1, 0));
        model.onMoveEnd(Offset(10, 0));

        verify(sessionService.addEvent(any)).called(2);
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
  });
}
