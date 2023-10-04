import 'package:collection/collection.dart';
import 'package:flutter/rendering.dart' as rendering;
import 'package:flutter/widgets.dart';
import 'package:session_mate_core/session_mate_core.dart';

extension EventPositionExtensions on EventPosition {
  EventPosition applyScroll(ScrollableDescription scrollableDescription) {
    switch (scrollableDescription.axis) {
      case ScrollAxis.vertical:
        return copyWith(y: scrollableDescription.scrollExtentByPixels);
      case ScrollAxis.horizontal:
        return copyWith(x: scrollableDescription.scrollExtentByPixels);
    }
  }
}

extension EventListExtension on List<UIEvent> {
  List<UIEvent> replaceInteractions(Iterable<UIEvent> updatedInteractions) {
    final updatedInteractionsIds = updatedInteractions.map((e) => e.id);

    final nonAffectedItems =
        whereNot((element) => updatedInteractionsIds.contains(element.id));

    return nonAffectedItems.followedBy(updatedInteractions).toList();
  }
}

extension OffsetEventPosition on Offset {
  EventPosition get asEventPosition {
    return EventPosition(x: dx, y: dy);
  }
}

extension EventPositionExtension on EventPosition {
  Offset get asOffset {
    return Offset(x, y);
  }

  EventPosition withScrollable(ScrollableDescription scrollable) {
    final scrollingPixels = scrollable.scrollExtentByPixels;

    if (scrollable.axis == ScrollAxis.vertical) {
      return copyWith(x: x, y: y + scrollingPixels);
    } else {
      return copyWith(x: x + scrollingPixels, y: y);
    }
  }
}

extension ScrollAxisExtension on Axis {
  ScrollAxis get asScrollAxis {
    switch (this) {
      case Axis.horizontal:
        return ScrollAxis.horizontal;
      case Axis.vertical:
        return ScrollAxis.vertical;
    }
  }
}

extension ScrollDirectionExtension on rendering.ScrollDirection {
  ScrollDirection get asScrollDirection {
    switch (this) {
      case rendering.ScrollDirection.idle:
        return ScrollDirection.idle;
      case rendering.ScrollDirection.forward:
        return ScrollDirection.forward;
      case rendering.ScrollDirection.reverse:
        return ScrollDirection.reverse;
    }
  }
}
