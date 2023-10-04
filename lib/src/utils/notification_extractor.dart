import 'package:flutter/material.dart';
import 'package:session_mate/src/app/locator_setup.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/extensions/event_extensions.dart';
import 'package:session_mate/src/utils/reactive_scrollable.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:session_mate_core/session_mate_core.dart' as core;

class NotificationExtractor {
  final log = getLogger('NotificationExtractorImp');

  final _reactiveScrollable = locator<ReactiveScrollable>();

  core.ScrollDirection? scrollDirection;
  late Offset globalPosition;
  late Offset localPosition;

  ScrollableDescription? lastScrollEvent;

  bool onlyScrollUpdateNotification(Notification notification) {
    log.v(notification);
    _setScrollablePositionAndScrollDirection(notification);

    if (notification is ScrollUpdateNotification) {
      return true;
    } else {
      return false;
    }
  }

  void _setScrollablePositionAndScrollDirection(Notification notification) {
    if (notification is ScrollStartNotification) {
      globalPosition = notification.dragDetails!.globalPosition;
      localPosition = notification.dragDetails!.localPosition;
    } else if (notification is UserScrollNotification) {
      scrollDirection = notification.direction.asScrollDirection;
    }
  }

  List<UIEvent> scrollEvents(
    ScrollableDescription scrollableDescription,
    List<UIEvent> uiEvents,
  ) {
    lastScrollEvent = scrollableDescription;

    _reactiveScrollable.currentScrollableDescription = scrollableDescription;

    final affectedInteractions =
        _reactiveScrollable.filterAffectedInteractionsByScrollable(uiEvents);

    final scrolledInteractions = _reactiveScrollable
        .moveInteractionsWithScrollable(affectedInteractions);

    return uiEvents.replaceInteractions(scrolledInteractions);
  }

  ScrollableDescription notificationToScrollableDescription(
    Notification notification,
  ) {
    log.v(notification);

    final notificationMetrics =
        (notification as ScrollUpdateNotification).metrics;

    return ScrollableDescription.fromNotification(
      globalPosition: globalPosition.asEventPosition,
      localPosition: localPosition.asEventPosition,
      metrics: core.ScrollMetrics(
        devicePixelRatio: notificationMetrics.devicePixelRatio,
        maxScrollExtent: notificationMetrics.maxScrollExtent,
        minScrollExtent: notificationMetrics.minScrollExtent,
        pixels: notificationMetrics.pixels,
        scrollDirection: notificationMetrics.axis == Axis.horizontal
            ? core.ScrollAxis.horizontal
            : core.ScrollAxis.vertical,
        viewportDimension: notificationMetrics.viewportDimension,
      ),
      scrollDirection: scrollDirection!,
    );
  }

  UIEvent syncInteractionWithScrollable(UIEvent event) {
    if (lastScrollEvent != null) {
      final scrollInteractionOrEmpty = scrollEvents(lastScrollEvent!, [event]);
      return scrollInteractionOrEmpty.isNotEmpty
          ? scrollInteractionOrEmpty.first
          : event;
    } else {
      return event;
    }
  }
}
