import 'package:flutter/material.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/utils/widget_finder.dart';
import 'package:session_mate_core/session_mate_core.dart';

class TextInputRecorder {
  final log = getLogger('TextInputRecorder');
  final _widgetFinder = locator<WidgetFinder>();

  final Map<Rect, _TrackedTextInputItem> _textFieldsOnScreen = {};

  Future<void> populateCurrentTextInfo() async {
    final textFieldInformation = _widgetFinder.getAllTextFieldsOnScreen();

    for (var (textEditingController, boundingBox) in textFieldInformation) {
      final trackedInputItem = _TrackedTextInputItem(
        controller: textEditingController,
        boundingBox: boundingBox,
        value: textEditingController.text,
      );

      _textFieldsOnScreen[boundingBox] = trackedInputItem;
    }
  }

  List<InputEvent> checkForTextChange() {
    final List<InputEvent> textInputEvents = [];
    final textFieldInformation = _widgetFinder.getAllTextFieldsOnScreen();

    for (var (textEditingController, boundingBox) in textFieldInformation) {
      final trackedTextFieldItem = _textFieldsOnScreen[boundingBox];

      if (trackedTextFieldItem == null) {
        log.e(
            '''SESSION MATE ERROR: No text field is found at the current position $boundingBox

        This means the textField was changed without recalculating the position. Please contact
        dane@sessionmate.dev with this issue, this should never happen.
        ''');
      } else {
        final inputHasChanged =
            trackedTextFieldItem.value != textEditingController.text;

        if (inputHasChanged) {
          final textInputPosition = boundingBox.center;

          textInputEvents.add(InputEvent(
            position: EventPosition(
              x: textInputPosition.dx,
              y: textInputPosition.dy,
            ),
          ));
        }
      }
    }

    return textInputEvents;
  }

  void clearTextInfo() {
    // 1. Clear the local text field data
  }
}

class _TrackedTextInputItem {
  final TextEditingController controller;
  final Rect boundingBox;
  final String value;

  _TrackedTextInputItem({
    required this.controller,
    required this.boundingBox,
    required this.value,
  });
}
