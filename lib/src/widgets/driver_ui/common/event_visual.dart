import 'package:flutter/material.dart';
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
    final order = isScrollEndIndicator ? '_final' : '';
    final key = '${event.automationKey}$order';
    final positionX = isScrollEndIndicator
        ? event.position.x + (event as ScrollEvent).scrollDelta!.x
        : event.position.x;
    final positionY = isScrollEndIndicator
        ? event.position.y + (event as ScrollEvent).scrollDelta!.y
        : event.position.y;

    return AnimatedSwitcher(
      key: Key(key),
      duration: const Duration(milliseconds: 300),
      child: viewModel.showDebugInformation
          ? _EventVerbose(
              index: index,
              event: event,
              isFinalPosition: isScrollEndIndicator,
              x: positionX,
              y: positionY,
            )
          : _EventSimple(
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
      decoration: BoxDecoration(
        color: isFinalPosition
            ? Color(event.type.alternativeColor)
            : Color(event.type.color),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '', //'${event.type.name.substring(0, 1).toUpperCase()}${index + 1}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _EventVerbose extends ViewModelWidget<DriverUIViewModel> {
  final int index;
  final UIEvent event;
  final double x;
  final double y;
  final bool isFinalPosition;
  const _EventVerbose({
    required this.index,
    required this.event,
    required this.x,
    required this.y,
    this.isFinalPosition = false,
  });

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    final order = isFinalPosition ? 'final' : 'initial';
    final legend = '$order - ${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)}';

    return Column(
      children: [
        Container(
          width: kEventVisualSize,
          height: kEventVisualSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: isFinalPosition
                ? Color(event.type.alternativeColor)
                : Color(event.type.color),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${event.type.name.substring(0, 1).toUpperCase()}${index + 1}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isFinalPosition
                ? Color(event.type.alternativeColor)
                : Color(event.type.color),
            shape: BoxShape.rectangle,
          ),
          padding: const EdgeInsets.all(2),
          child: Center(
            child: Text(
              legend,
              style: TextStyle(color: Colors.black, fontSize: 9),
            ),
          ),
        ),
      ],
    );
  }
}
