import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/app/logger.dart';

class WidgetFinder {
  final log = getLogger('WidgetFinder');

  TextField? getTextFieldAtPosition({
    required Offset position,
    bool verbose = false,
  }) {
    final stopwatch = Stopwatch()..start();
    final textFields = find.byType(TextField).hitTestable().evaluate();
    if (verbose) {
      print('⏰ findByType executed in - ${stopwatch.elapsed}');
    }

    for (final textFieldElement in textFields) {
      try {
        final renderObject = textFieldElement.findRenderObject() as RenderBox;
        if (verbose) {
          print('⏰ FindRenderObject executed in - ${stopwatch.elapsed}');
        }
        final translation = renderObject.getTransformTo(null).getTranslation();
        if (verbose) {
          print('⏰ getTransformTo executed in - ${stopwatch.elapsed}');
        }

        final offset = Offset(translation.x, translation.y);
        final textFieldRect = renderObject.paintBounds.shift(offset);

        print('⏰ - TextField rect: $textFieldRect and position: $position');

        if (textFieldRect.contains(position)) {
          return textFieldElement.widget as TextField;
        }
      } catch (e) {
        log.e(e);
      }
    }

    return null;
  }
}
