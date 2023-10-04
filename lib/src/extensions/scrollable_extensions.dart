import 'package:session_mate/src/extensions/ui_extensions.dart';
import 'package:session_mate_core/session_mate_core.dart';

extension ScrollableDescriptionExtension on ScrollableDescription {
  ScrollableDescription transferBy(
      ScrollableDescription? scrollableDescription) {
    if (scrollableDescription == null || scrollableDescription == this) {
      return this;
    }

    switch (scrollableDescription.axis) {
      case ScrollAxis.vertical:
        return copyWith(
          nested: true,
          rect: ScrollableRect(
            rect.left,
            rect.top + scrollableDescription.scrollExtentByPixels,
            rect.width,
            rect.height,
          ),
        );
      case ScrollAxis.horizontal:
        return copyWith(
          nested: true,
          rect: ScrollableRect(
            rect.left + scrollableDescription.scrollExtentByPixels,
            rect.top,
            rect.width,
            rect.height,
          ),
        );
    }
  }
}

extension ScrollableRectExtension on ScrollableRect {
  bool biggerThan(ScrollableRect anotherRect) {
    if ((asRect.size.width * asRect.size.height) >
        (anotherRect.asRect.size.width * anotherRect.asRect.size.height)) {
      return true;
    } else {
      return false;
    }
  }
}
