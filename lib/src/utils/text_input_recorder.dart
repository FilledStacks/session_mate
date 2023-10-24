import 'package:flutter/material.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/data_masking_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate/src/utils/time_utils.dart';
import 'package:session_mate/src/utils/widget_finder.dart';
import 'package:session_mate/src/widgets/session_mate_route_tracker.dart';
import 'package:session_mate_core/session_mate_core.dart';

class TextInputRecorder {
  final log = getLogger('TextInputRecorder');
  final _widgetFinder = locator<WidgetFinder>();
  final _maskService = locator<DataMaskingService>();
  final _timeUtils = locator<TimeUtils>();
  final _sessionService = locator<SessionService>();
  final _routeTracker = locator<SessionMateRouteTracker>();

  final List<TrackedTextInputItem> _textFieldsOnScreen;

  TextInputRecorder({
    @visibleForTesting List<TrackedTextInputItem>? initialTextFieldsOnScreen,
  }) : _textFieldsOnScreen = initialTextFieldsOnScreen ?? [];

  Future<void> populateCurrentTextInfo() async {
    if (printVerboseLogs) {
      print('🖋️ populateCurrentTextInfo');
    }

    final textFieldInformation = _widgetFinder.getAllTextFieldsOnScreen();

    for (var (textEditingController, boundingBox) in textFieldInformation) {
      final trackedInputItem = TrackedTextInputItem(
        controller: textEditingController,
        boundingBox: boundingBox,
        value: textEditingController.text,
      );

      _textFieldsOnScreen.add(trackedInputItem);
    }

    if (printVerboseLogs) {
      print(
          '🖋️ Tracking ${_textFieldsOnScreen.length} text fields on screen.');
    }
  }

  List<InputEvent> checkForTextChange() {
    if (printVerboseLogs) {
      print('🖋️ checkForTextChange');
    }
    final List<InputEvent> textInputEvents = [];

    if (printVerboseLogs) {
      log.i('🖋️ --------- Comparing Text Fields ---------');
      log.v('🖋️ Tracked Field count: ${_textFieldsOnScreen.length}');
      log.i('🖋️ ------------------------------------------');
    }

    for (var trackedTextFieldItem in _textFieldsOnScreen) {
      final inputHasChanged =
          trackedTextFieldItem.value != trackedTextFieldItem.controller.text;
      print(
          '🖋️ TrackedTextField value: ${trackedTextFieldItem.value} , currentTextFieldValue:${trackedTextFieldItem.controller.text}');

      if (inputHasChanged) {
        final textInputPosition = trackedTextFieldItem.boundingBox.center;

        textInputEvents.add(InputEvent(
          position: EventPosition(
            x: textInputPosition.dx,
            y: textInputPosition.dy,
          ),
          inputData: _maskService.stringSubstitution(
            trackedTextFieldItem.controller.text,
          ),
          order: _timeUtils.timestamp,
          navigationStackId: _sessionService.navigationStackId,
          view: _routeTracker.currentRoute,
        ));
      }
    }
    if (printVerboseLogs) {
      print('🖋️ ---------- Text Field Diffs ----------');
      print(
          '🖋️ ${textInputEvents.length} distinct text input changes has occured here are the details:');
      for (final inputEvent in textInputEvents) {
        print(
            '🖋️ Field at (${inputEvent.position.x}, ${inputEvent.position.y}) changed to ${inputEvent.inputData}');
      }
      print('🖋️ --------------------------------------');
    }

    return textInputEvents;
  }

  void clearTextInfo() {
    if (printVerboseLogs) {
      log.i('🖋️ clearTextInfo');
    }
    _textFieldsOnScreen.clear();
  }
}

class TrackedTextInputItem {
  final TextEditingController controller;
  final Rect boundingBox;
  final String value;

  TrackedTextInputItem({
    required this.controller,
    required this.boundingBox,
    required this.value,
  });
}
