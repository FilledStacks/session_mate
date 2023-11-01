import 'package:flutter/material.dart';
import 'package:session_mate/session_mate.dart';
import 'package:session_mate/src/widgets/driver_ui/common/driver_bar.dart';
import 'package:session_mate/src/widgets/driver_ui/common/session_list.dart';
import 'package:session_mate/src/widgets/driver_ui/common/user_idle_time.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:session_mate/src/widgets/driver_ui/events_visualizer.dart';
import 'package:session_mate/src/widgets/hittable_stack.dart';
import 'package:stacked/stacked.dart';

class DriverUI extends StackedView<DriverUIViewModel> {
  final Widget child;
  const DriverUI({super.key, required this.child});

  @override
  Widget builder(
    BuildContext context,
    DriverUIViewModel viewModel,
    // ignore: avoid_renaming_method_parameters
    Widget? _,
  ) {
    return Scaffold(
      body: Stack(
        children: [
          HittableStack(
            children: [
              IgnorePointer(
                ignoring: viewModel.showReplayUI,
                child: AnimatedOpacity(
                  opacity: viewModel.showReplayUI ? 0.5 : 1.0,
                  duration: const Duration(milliseconds: 600),
                  child: NotificationListener(
                    onNotification: viewModel.onClientNotifiaction,
                    child: Builder(builder: (context) {
                      if (!viewModel.showReplayUI) return child;

                      return const SizedBox.shrink();
                    }),
                  ),
                ),
              ),
              const EventsVisualizer(),
            ],
          ),
          if (viewModel.showUserIdleTime) const UserIdleTime(),
          if (viewModel.showReplayUI) ...[
            if (viewModel.showSessionList) const SessionList(),
            Positioned(
              bottom: MediaQuery.of(context).size.height * .025,
              left: MediaQuery.of(context).size.width * .05,
              child: const DriverBar(),
            ),
          ]
        ],
      ),
    );
  }

  @override
  void onViewModelReady(DriverUIViewModel viewModel) {
    viewModel.loadSessions();
  }

  @override
  DriverUIViewModel viewModelBuilder(BuildContext context) =>
      DriverUIViewModel(onReplayCompleted: () => SessionMate.restart(context));
}
