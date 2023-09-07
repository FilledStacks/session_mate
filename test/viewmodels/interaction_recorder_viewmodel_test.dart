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
  });
}
