import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/extensions/event_extensions.dart';
import 'package:session_mate_core/session_mate_core.dart';

class WidgetFinder {
  final log = getLogger('WidgetFinder');

  Iterable<ScrollableDescription> getAllScrollablesOnScreen() {
    final scrollableItemsInWidgetTree =
        find.byType(Scrollable).hitTestable().evaluate();
    log.v('scrollableItemsInWidgetTree: $scrollableItemsInWidgetTree');
    final extractedScrollableDescriptions = scrollableItemsInWidgetTree
        .map((item) {
          try {
            RenderBox renderBox = item.findRenderObject() as RenderBox;

            Offset globalPostion = renderBox.localToGlobal(Offset.zero);
            final position =
                (item.widget as Scrollable).controller!.positions.first;

            final scrollOffsetInPixels = position.pixels;
            final maxscrollOffsetInPixels = position.maxScrollExtent;
            final axis = position.axis;
            final bottomRightPoint = globalPostion.translate(
              renderBox.size.width,
              renderBox.size.height,
            );
            final rect = ScrollableRect(
              globalPostion.dx,
              globalPostion.dy,
              bottomRightPoint.dx,
              bottomRightPoint.dy,
            );

            return ScrollableDescription(
                axis: axis.asScrollAxis,
                rect: rect,
                scrollOffsetInPixels: scrollOffsetInPixels,
                maxScrollExtentByPixels: maxscrollOffsetInPixels);
          } catch (e) {
            log.e(e);
            return null;
          }
        })
        .where((element) => element != null)
        .cast<ScrollableDescription>();

    log.i('extractedScrollableDescriptions: $extractedScrollableDescriptions');

    return extractedScrollableDescriptions;
  }

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
