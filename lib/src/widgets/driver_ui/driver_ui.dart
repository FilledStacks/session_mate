import 'package:flutter/material.dart';
import 'package:session_mate/src/widgets/driver_ui/common/driver_bar/driver_bar.dart';
import 'package:session_mate/src/widgets/driver_ui/common/event_info.dart';
import 'package:session_mate/src/widgets/driver_ui/common/session_list.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:session_mate/src/widgets/hittable_stack.dart';
import 'package:stacked/stacked.dart';

class DriverUI extends StackedView<DriverUIViewModel> {
  final Widget child;

  const DriverUI({
    Key? key,
    required this.child,
  }) : super(key: key);

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
                  child: child,
                ),
              ),
              ...viewModel.sessionInteractions.asMap().entries.map((i) {
                return EventInfo(index: i.key, event: i.value);
              }),
              ...viewModel.scrollInteractions.asMap().entries.map((i) {
                return EventInfo(
                  index: i.key,
                  event: i.value,
                  isFinalPosition: true,
                );
              }),
            ],
          ),
          if (viewModel.showReplayUI) ...[
            if (viewModel.showSessionList) const SessionList(),
            // const SessionActions(),
            const DriverBar(),
          ],
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
      DriverUIViewModel();
}
