import 'package:flutter/material.dart';
import 'package:session_mate/src/widgets/driver_ui/common/session_actions.dart';
import 'package:session_mate/src/widgets/driver_ui/common/session_list.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:session_mate/src/widgets/hittable_stack.dart';
import 'package:stacked/stacked.dart';

const double _kInteractionWidth = 20;
const double _kInteractionHeight = 20;

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
      body: SafeArea(
        child: Stack(
          children: [
            HittableStack(
              children: [
                IgnorePointer(
                  ignoring: viewModel.showReplayUI,
                  child: AnimatedOpacity(
                    opacity: viewModel.showReplayUI ? 0.4 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: child,
                  ),
                ),
                ...viewModel.sessionInteractions.map(
                  (interaction) => Positioned(
                    top: interaction.position.y - _kInteractionHeight / 2,
                    left: interaction.position.x - _kInteractionWidth / 2,
                    key: Key(interaction.automationKey),
                    child: Container(
                      width: _kInteractionWidth,
                      height: _kInteractionHeight,
                      decoration: BoxDecoration(
                        color: Color(interaction.type.color),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          interaction.type.name.substring(0, 1).toUpperCase(),
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (viewModel.showReplayUI) ...[
              const SessionList(),
              const SessionActions(),
            ],
          ],
        ),
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
