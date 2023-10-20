import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/utils/text_input_recorder.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('TextInputRecorerTest -', () {
    group('checkForTextChange -', () {
      test('When text did not change, should return no input events', () {
        getAndRegisterWidgetFinder(allTextFieldsOnScreen: [
          (TextEditingController(), Rect.zero),
        ]);
        final textInputRecorder = TextInputRecorder();
        textInputRecorder.populateCurrentTextInfo();

        final result = textInputRecorder.checkForTextChange();

        expect(result, []);
      });

      test(
          'When 1 text field changed, should return input event for that text field',
          () {
        getAndRegisterWidgetFinder(allTextFieldsOnScreen: [
          (TextEditingController(text: 'Changed'), Rect.zero),
        ]);
        final textInputRecorder = TextInputRecorder(initialTextFieldsOnScreen: {
          Rect.zero: TrackedTextInputItem(
            boundingBox: Rect.zero,
            controller: TextEditingController(),
            value: 'Start',
          )
        });

        final result = textInputRecorder.checkForTextChange();

        expect(result.length, 1);
        expect(result.first.inputData, 'Changed');
      });

      test(
          'When 2 text fields changed out of 5, should return 2 InputEvents for that text field',
          () {
        getAndRegisterWidgetFinder(allTextFieldsOnScreen: [
          (TextEditingController(text: 'Changed'), Rect.fromLTWH(1, 2, 3, 4)),
          (TextEditingController(text: 'Changed2'), Rect.fromLTWH(1, 2, 3, 5)),
        ]);
        final textInputRecorder = TextInputRecorder(
          initialTextFieldsOnScreen: {
            Rect.fromLTWH(1, 2, 3, 4): TrackedTextInputItem(
              boundingBox: Rect.fromLTWH(1, 2, 3, 4),
              controller: TextEditingController(),
              value: 'Start',
            ),
            Rect.fromLTWH(1, 2, 3, 5): TrackedTextInputItem(
              boundingBox: Rect.fromLTWH(1, 2, 3, 5),
              controller: TextEditingController(),
              value: 'Start',
            ),
            Rect.fromLTWH(1, 2, 5, 4): TrackedTextInputItem(
              boundingBox: Rect.fromLTWH(1, 2, 5, 4),
              controller: TextEditingController(),
              value: 'Start',
            ),
            Rect.fromLTWH(1, 3, 5, 4): TrackedTextInputItem(
              boundingBox: Rect.fromLTWH(1, 3, 5, 4),
              controller: TextEditingController(),
              value: 'Start',
            ),
            Rect.fromLTWH(5, 3, 5, 4): TrackedTextInputItem(
              boundingBox: Rect.fromLTWH(5, 3, 5, 4),
              controller: TextEditingController(),
              value: 'Start',
            ),
          },
        );

        final result = textInputRecorder.checkForTextChange();

        expect(result.length, 2);
        expect(result.first.inputData, 'Changed');
        expect(result.last.inputData, 'Changed2');
      });
    });
  });
}
