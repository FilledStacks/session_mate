import 'package:flutter/material.dart';
import 'package:session_mate/src/extensions/ui_extensions.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class EventVisual extends ViewModelWidget<DriverUIViewModel> {
  final int index;
  final UIEvent event;
  final bool isScrollEndIndicator;
  const EventVisual({
    super.key,
    required this.index,
    required this.event,
    this.isScrollEndIndicator = false,
  });

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    final positionX = isScrollEndIndicator
        ? event.position.x + (event as ScrollEvent).scrollDelta!.x
        : event.position.x;

    final positionY = isScrollEndIndicator
        ? event.position.y + (event as ScrollEvent).scrollDelta!.y
        : event.position.y;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _EventSimple(
        index: index,
        event: event,
        isFinalPosition: isScrollEndIndicator,
        x: positionX,
        y: positionY,
      ),
    );
  }
}

class _EventSimple extends ViewModelWidget<DriverUIViewModel> {
  final int index;
  final UIEvent event;
  final double x;
  final double y;
  final bool isFinalPosition;
  const _EventSimple({
    required this.index,
    required this.event,
    required this.x,
    required this.y,
    this.isFinalPosition = false,
  });

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    return Container(
      width: kEventVisualSize,
      height: kEventVisualSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: event.type.toColor,
          width: 1,
        ),
        shape: BoxShape.circle,
      ),
      child: Container(
        width: 2,
        height: 2,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: event.type.toColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
