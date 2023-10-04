import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/extensions/event_extensions.dart';
import 'package:session_mate/src/extensions/scrollable_extensions.dart';
import 'package:session_mate/src/extensions/ui_extensions.dart';
import 'package:session_mate_core/session_mate_core.dart';

class ScrollApplicator {
  final log = getLogger('ScrollApplicator');

  UIEvent applyScrollableToEvent(
    Iterable<ScrollableDescription> scrollables,
    UIEvent event,
  ) {
    log.v(event);
    final scrollablesBelowInteraction = scrollables.where(
      (element) => element.rect.asRect.contains(
        event.position.asOffset,
      ),
    );

    event = event.copyWith(externalities: null);

    /// If there is no overlapping with any scrollable
    /// Return the interaction without changing anything
    if (scrollablesBelowInteraction.isEmpty) return event;

    if (event.isScrollable) {
      return storeDescriptionInScrollableExternalities(
        scrollablesBelowInteraction,
        event,
      );
    } else {
      return storeDescriptionInExternalities(
          scrollablesBelowInteraction, event);
    }
  }

  UIEvent storeDescriptionInScrollableExternalities(
    Iterable<ScrollableDescription> scrollablesBelowInteraction,
    UIEvent interaction,
  ) {
    log.v(scrollablesBelowInteraction);

    /// When interaction type is scrollable and there is only one list below it,
    /// Shouldn't add the list to externalities of the interaction cause it will
    /// scroll itself
    if (interaction.isScrollable && scrollablesBelowInteraction.length == 1) {
      return interaction;
    }

    final biggestScrollable =
        findBiggestScrollable(scrollablesBelowInteraction);

    interaction = interaction.copyWith(
      externalities: [
        biggestScrollable.transferBy(biggestScrollable),
      ],
      position: interaction.position.withScrollable(biggestScrollable),
    );
    return interaction;
  }

  UIEvent storeDescriptionInExternalities(
    Iterable<ScrollableDescription> scrollablesBelowInteraction,
    UIEvent event,
  ) {
    final biggestScrollable =
        findBiggestScrollable(scrollablesBelowInteraction);

    for (var scrollable in scrollablesBelowInteraction.toList()) {
      event = event.copyWith(
        externalities: [
          ...event.externalities ?? {},
          scrollable.transferBy(biggestScrollable),
        ],
        position: event.position.withScrollable(scrollable),
      );
    }
    return event;
  }

  ScrollableDescription findBiggestScrollable(
      Iterable<ScrollableDescription> scrollablesBelowInteraction) {
    return scrollablesBelowInteraction.reduce(
      (curr, next) => curr.rect.biggerThan(next.rect) ? curr : next,
    );
  }
}
