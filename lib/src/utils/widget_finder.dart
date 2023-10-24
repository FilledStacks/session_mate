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
    // log.v('scrollableItemsInWidgetTree: $scrollableItemsInWidgetTree');
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

    // log.i('extractedScrollableDescriptions: $extractedScrollableDescriptions');

    return extractedScrollableDescriptions;
  }

  List<(TextEditingController, Rect)> getAllTextFieldsOnScreen() {
    return find
        .byType(TextField)
        .hitTestable()
        .evaluate()
        .map((textFieldElement) {
      final renderObject = textFieldElement.findRenderObject() as RenderBox;
      final translation = renderObject.getTransformTo(null).getTranslation();
      final offset = Offset(translation.x, translation.y);
      final textFieldRect = renderObject.paintBounds.shift(offset);

      final textField = textFieldElement.widget as TextField;

      if (textField.controller == null) {
        log.e(
          'SESSION MATE ERROR: TextField in the UI tree has no controller. This means we cannot record your input events',
        );
      }

      return (textField.controller ?? TextEditingController(), textFieldRect);
    }).toList();
  }
}
