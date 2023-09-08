import 'package:flutter/material.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

const double _kInteractionWidth = 20;
const double _kInteractionHeight = 20;

class EventInfo extends ViewModelWidget<DriverUIViewModel> {
  final int index;
  final UIEvent event;
  final bool isFinalPosition;
  const EventInfo({
    super.key,
    required this.index,
    required this.event,
    this.isFinalPosition = false,
  });

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    final order = isFinalPosition ? '_final' : '';
    final key = '${event.automationKey}$order';
    final positionX = isFinalPosition
        ? event.position.x + (event as ScrollEvent).scrollDelta!.x
        : event.position.x;
    final positionY = isFinalPosition
        ? event.position.y + (event as ScrollEvent).scrollDelta!.y
        : event.position.y;

    return Positioned(
      top: positionY - _kInteractionHeight / 2,
      left: positionX - _kInteractionWidth / 2,
      key: Key(key),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: viewModel.showVerboseEvent
            ? _EventVerbose(
                index: index,
                event: event,
                isFinalPosition: isFinalPosition,
                x: positionX,
                y: positionY,
              )
            : _EventSimple(
                index: index,
                event: event,
                isFinalPosition: isFinalPosition,
                x: positionX,
                y: positionY,
              ),
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
    return GestureDetector(
      onTap: () {
        print('${isFinalPosition ? "final" : "initial"} position: $x, $y');
        viewModel.onEventTapped(event);
      },
      child: Container(
        width: _kInteractionWidth,
        height: _kInteractionHeight,
        decoration: BoxDecoration(
          color: Color(event.type.color).withOpacity(
            isFinalPosition ? 0.25 : 1.0,
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${event.type.name.substring(0, 1).toUpperCase()}${index + 1}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
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
        GestureDetector(
          onTap: () {
            print('$order - $x, $y');
            viewModel.onEventTapped(event);
          },
          child: Container(
            width: _kInteractionWidth,
            height: _kInteractionHeight,
            decoration: BoxDecoration(
              color: Color(event.type.color).withOpacity(
                isFinalPosition ? 0.25 : 1.0,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${event.type.name.substring(0, 1).toUpperCase()}${index + 1}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Container(
          // width: _kInteractionWidth * 2,
          // height: _kInteractionHeight * 2,
          decoration: BoxDecoration(
            color: Color(event.type.color).withOpacity(
              isFinalPosition ? 0.25 : 1.0,
            ),
            shape: BoxShape.rectangle,
          ),
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