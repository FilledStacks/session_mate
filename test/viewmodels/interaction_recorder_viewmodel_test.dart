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

    group('updateActiveCommand -', () {
      test(
          'When called with type input, should update active command to type Input',
          () {
        final model = _getModel();

        model.startCommandRecording(
          position: Offset(1, 0),
          type: InteractionType.tap,
        );

        model.updateActiveCommand(type: InteractionType.input);
        expect(model.activeCommand?.type, InteractionType.input);
      });
    });

    group('concludeAndClear -', () {
      test('When called, should clear latest active command', () {
        final model = _getModel();

        model.startCommandRecording(
          position: Offset(1, 0),
          type: InteractionType.tap,
        );

        model.concludeAndClear();
        expect(model.hasActiveCommand, false);
      });

      test('When called, should save the active command to the sessionService',
          () {
        final sessionSercice = getAndRegisterSessionService();
        final model = _getModel();

        final event = UIEvent(
          position: EventPosition(x: 1, y: 0),
          type: InteractionType.tap,
        );

        model.startCommandRecording(
          position: Offset(1, 0),
          type: InteractionType.tap,
        );

        model.concludeAndClear();
        verify(sessionSercice.addEvent(event));
      });
    });

    group('concludeActiveCommand -', () {
      test(
          'When called and active command is input, should store the textEditingController text in the input command',
          () {
        final model = _getModel();

        model.startCommandRecording(
          position: Offset(1, 0),
          type: InteractionType.tap,
        );

        model.updateActiveCommand(type: InteractionType.input);

        model.updateInputCommandDetails(
            inputFieldController: TextEditingController(
          text: 'This should be eht text',
        ));

        model.concludeActiveCommand();
        expect(
          model.activeCommand?.inputData,
          'This should be eht text',
        );
      });

      test('When called, should clear activeTextEditingController', () {
        final model = _getModel();

        model.startCommandRecording(
          position: Offset(1, 0),
          type: InteractionType.tap,
        );

        model.concludeActiveCommand();
        expect(model.hasActiveTextEditingController, false);
      });
    });
  });
}
