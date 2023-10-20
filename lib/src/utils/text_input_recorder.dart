import 'package:flutter/material.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/utils/widget_finder.dart';
import 'package:session_mate_core/session_mate_core.dart';

class TextInputRecorder {
  final _widgetFinder = locator<WidgetFinder>();

  final List<_TrackedTextInputItem> _textFieldsOnScreen = [];

  Future<void> populateCurrentTextInfo() async {
    final textFieldInformation = _widgetFinder.getAllTextFieldsOnScreen();

    for (var (textEditingController, boundingBox) in textFieldInformation) {
      final trackedInputItem = _TrackedTextInputItem(
        controller: textEditingController,
        boundingBox: boundingBox,
        value: textEditingController.text,
      );

      _textFieldsOnScreen.add(trackedInputItem);
    }
  }

  List<InputEvent> checkForTextChange() {
    // 1. Get all textFields on screen
    // 2. Compare the start value with the latest textField controller
    // 3. If there's a difference add the new value as an input event
    // at the center of the bounding box
    return [];
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
