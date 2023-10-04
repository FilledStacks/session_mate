import 'package:flutter/material.dart';
import 'package:session_mate/src/widgets/updateable_event/updateable_event_viewmodel.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

const double _kInteractionWidth = 30;
const double _kInteractionHeight = 30;

class UpdatableEvent extends StackedView<UpdatableEventViewModel> {
  final int index;
  final UIEvent event;
  final bool isScrollEndIndicator;

  const UpdatableEvent({
    super.key,
    required this.index,
    required this.event,
    this.isScrollEndIndicator = false,
  });

  @override
  Widget builder(
    BuildContext context,
    UpdatableEventViewModel viewModel,
    Widget? child,
  ) {
    final order = isScrollEndIndicator ? '_final' : '';
    final key = '${event.automationKey}$order';

    return Positioned(
      top: viewModel.x - _kInteractionHeight / 2,
      left: viewModel.y - _kInteractionWidth / 2,
      key: Key(key),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _EventUI(
          index: index,
          event: event,
          isFinalPosition: isScrollEndIndicator,
        ),
      ),
    );
  }

  @override
  UpdatableEventViewModel viewModelBuilder(BuildContext context) {
    return UpdatableEventViewModel(x: event.position.x, y: event.position.y);
  }
}

class _EventUI extends StatelessWidget {
  final int index;
  final UIEvent event;

  final bool isFinalPosition;
  const _EventUI({
    required this.index,
    required this.event,
    this.isFinalPosition = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kInteractionWidth,
      height: _kInteractionHeight,
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
