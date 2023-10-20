import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/utils/text_input_recorder.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('TextInputRecorerTest -', () {
    setUpAll(registerServices);
    tearDownAll(locator.reset);

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
        getAndRegisterConfigurationService(dataMaskingEnabled: false);
        getAndRegisterRealMaskingService();

        final textEditingController = TextEditingController();

        final textInputRecorder = TextInputRecorder(initialTextFieldsOnScreen: [
          TrackedTextInputItem(
            boundingBox: Rect.zero,
            controller: textEditingController,
            value: 'Start',
          )
        ]);

        textEditingController.text = 'Changed';

        final result = textInputRecorder.checkForTextChange();

        expect(result.length, 1);
        expect(result.first.inputData, 'Changed');
      });

      test(
          'When 2 text fields changed out of 5, should return 2 InputEvents for that text field',
          () {
        getAndRegisterRealMaskingService();

        final controller1 = TextEditingController(text: 'Changed');
        final controller2 = TextEditingController(text: 'Changed2');

        final textInputRecorder = TextInputRecorder(
          initialTextFieldsOnScreen: [
            TrackedTextInputItem(
              boundingBox: Rect.fromLTWH(1, 2, 3, 4),
              controller: controller1,
              value: 'Start',
            ),
            TrackedTextInputItem(
              boundingBox: Rect.fromLTWH(1, 2, 3, 5),
              controller: controller2,
              value: 'Start',
            ),
            TrackedTextInputItem(
              boundingBox: Rect.fromLTWH(1, 2, 5, 4),
              controller: TextEditingController(),
              value: '',
            ),
            TrackedTextInputItem(
              boundingBox: Rect.fromLTWH(1, 3, 5, 4),
              controller: TextEditingController(),
              value: '',
            ),
            TrackedTextInputItem(
              boundingBox: Rect.fromLTWH(5, 3, 5, 4),
              controller: TextEditingController(),
              value: '',
            ),
          ],
        );

        controller1.text = 'Changed';
        controller2.text = 'Changed2';

        final result = textInputRecorder.checkForTextChange();

        expect(result.length, 2);
        expect(result.first.inputData, 'Changed');
        expect(result.last.inputData, 'Changed2');
      });
    });
  });
}
