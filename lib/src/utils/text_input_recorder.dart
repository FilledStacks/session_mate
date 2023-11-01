import 'package:flutter/material.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/helpers/logger_helper.dart';
import 'package:session_mate/src/services/configuration_service.dart';
import 'package:session_mate/src/services/data_masking_service.dart';
import 'package:session_mate/src/services/session_service.dart';
import 'package:session_mate/src/utils/time_utils.dart';
import 'package:session_mate/src/utils/widget_finder.dart';
import 'package:session_mate/src/widgets/session_mate_route_tracker.dart';
import 'package:session_mate_core/session_mate_core.dart';

class TextInputRecorder {
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
    logUIEvent('🖋️ populateCurrentTextInfo', onlyOnVerbose: true);

    final textFieldInformation = _widgetFinder.getAllTextFieldsOnScreen();

    for (var (textEditingController, boundingBox) in textFieldInformation) {
      final trackedInputItem = TrackedTextInputItem(
        controller: textEditingController,
        boundingBox: boundingBox,
        value: textEditingController.text,
      );

      _textFieldsOnScreen.add(trackedInputItem);
    }

    logUIEvent(
      '🖋️ Tracking ${_textFieldsOnScreen.length} text fields on screen.',
      onlyOnVerbose: true,
    );
  }

  List<InputEvent> checkForTextChange() {
    logUIEvent('🖋️ checkForTextChange', onlyOnVerbose: true);
    final List<InputEvent> textInputEvents = [];

    logUIEvent(
      '''
🖋️ --------- Comparing Text Fields ---------
🖋️ Tracked Field count: ${_textFieldsOnScreen.length}
🖋️ ------------------------------------------''',
      onlyOnVerbose: true,
    );

    for (var trackedTextFieldItem in _textFieldsOnScreen) {
      final inputHasChanged =
          trackedTextFieldItem.value != trackedTextFieldItem.controller.text;
      logUIEvent(
        '🖋️ TrackedTextField value: ${trackedTextFieldItem.value} , currentTextFieldValue:${trackedTextFieldItem.controller.text}',
      );

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
          startedAt: _timeUtils.timestamp,
          navigationStackId: _sessionService.navigationStackId,
          view: _routeTracker.currentRoute,
        ));
      }
    }

    if (printVerboseLogs) {
      List<String> events = [];
      for (final inputEvent in textInputEvents) {
        events.add(
          '🖋️ Field at (${inputEvent.position.x}, ${inputEvent.position.y}) changed to ${inputEvent.inputData}',
        );
      }

      logUIEvent('''
🖋️ ---------- Text Field Diffs ----------
🖋️ ${textInputEvents.length} distinct text input changes has occured here are the details: ${(events.isNotEmpty) ? events.join("\n") : ''}
🖋️ --------------------------------------''');
    }

    return textInputEvents;
  }

  void clearTextInfo() {
    logUIEvent('🖋️ clearTextInfo', onlyOnVerbose: true);
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
