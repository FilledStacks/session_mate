import 'package:flutter/material.dart';
import 'package:session_mate/src/extensions/event_position_extensions.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate_core/session_mate_core.dart';

// TODO (Rename): UIEventUpdater
class ReactiveScrollable {
  late ScrollableDescription currentScrollableDescription;

  Iterable<UIEvent> filterAffectedInteractionsByScrollable(
    List<UIEvent> uiEvents,
  ) {
    return uiEvents.where((uiEvent) {
      if (uiEvent.externalities == null) return false;

      Offset offsetDeviation = calculateOffsetDeviation(
        currentScrollableDescription,
        uiEvent,
      );

      return uiEvent.externalities!
          .where((sd) => sd.axis == currentScrollableDescription.axis)
          .any(
        (interacrionSd) {
          final distance = _distanceSquaredBetweenScrollableAndExternal(
            interacrionSd,
            offsetDeviation,
            currentScrollableDescription,
          );

          final included = distance < kScrollableDetectionForgiveness;
          return included;
        },
      );
    });
  }

  double _distanceSquaredBetweenScrollableAndExternal(
    ScrollableDescription interacrionSd,
    Offset offsetDeviation,
    ScrollableDescription sd,
  ) {
    final deviation = (interacrionSd.nested ? offsetDeviation : Offset.zero);
    final descriptionTopLeft =
        Offset(interacrionSd.rect.left, interacrionSd.rect.top);
    final offset = descriptionTopLeft - deviation;
    return (offset - descriptionTopLeft).distanceSquared;
  }

  Offset calculateOffsetDeviation(
    ScrollableDescription scrollableDescription,
    UIEvent interaction,
  ) {
    late Offset offsetDeviation;
    if (scrollableDescription.axis == ScrollAxis.vertical) {
      offsetDeviation = Offset(interaction.position.x, 0);
    } else {
      offsetDeviation = Offset(0, -(interaction.position.y));
    }
    return offsetDeviation;
  }

  Iterable<UIEvent> moveInteractionsWithScrollable(
    Iterable<UIEvent> affectedEvents,
  ) {
    return affectedEvents.map((event) => event.copyWith(
        position: event.position.applyScroll(currentScrollableDescription)));
  }
}
