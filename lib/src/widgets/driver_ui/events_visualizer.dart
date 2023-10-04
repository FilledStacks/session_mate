import 'package:flutter/material.dart';
import 'package:session_mate/src/utils/interaction_utils.dart';
import 'package:session_mate/src/widgets/driver_ui/common/event_visual.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:session_mate_core/session_mate_core.dart';
import 'package:stacked/stacked.dart';

class EventsVisualizer extends ViewModelWidget<DriverUIViewModel> {
  const EventsVisualizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DriverUIViewModel viewModel) {
    final size = MediaQuery.of(context).size;
    return ValueListenableBuilder<List<UIEvent>>(
        valueListenable: viewModel.eventsNotifier,
        builder: (_, events, __) {
          return Stack(
            children: [
              ...events
                  .where((interaction) =>
                      InteractionUtils.visibleOnScreen(interaction, size))
                  .map(
                    (event) => Positioned(
                      top: event.position.y,
                      left: event.position.x,
                      child: EventVisual(
                        event: event,
                        index: events.indexOf(event),
                      ),
                    ),
                  )
            ],
          );
        });
  }
}
