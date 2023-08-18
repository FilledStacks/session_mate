import 'package:flutter/material.dart';
import 'package:session_mate/src/widgets/driver_ui/driver_ui_viewmodel.dart';
import 'package:session_mate/src/widgets/hittable_stack.dart';
import 'package:session_mate_core/session_mate_core.dart';
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
    return HittableStack(
      children: [
        child,
        ...viewModel.sessionInteractions.map(
          (interaction) => Positioned(
            top: interaction.position.y - _kInteractionHeight / 2,
            left: interaction.position.x - _kInteractionWidth / 2,
            key: Key(interaction.automationKey),
            child: Container(
              width: _kInteractionWidth,
              height: _kInteractionHeight,
              decoration: BoxDecoration(
                color: interaction.type == InteractionType.tap
                    ? Colors.red
                    : Colors.purple,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        if (viewModel.showReplayUI)
          Positioned(
            top: 100,
            left: 35,
            height: MediaQuery.of(context).size.height - 100 - 100,
            width: MediaQuery.of(context).size.width - 70,
            child: ListView.builder(
              itemCount: viewModel.sessions.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => viewModel.selectSession(index),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  child: Text(
                    viewModel.sessions[index].id,
                    style: TextStyle(fontSize: 20),
                  ),
                  decoration: BoxDecoration(
                    color: viewModel.isSessionSelected(index)
                        ? Colors.blue
                        : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
        if (viewModel.showReplayUI)
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: MaterialButton(
              minWidth: 80,
              onPressed: viewModel.startSession,
              color:
                  viewModel.hasSelectedSession ? Colors.blue : Colors.grey[400],
              child: Text('Replay Session'),
            ),
          )
      ],
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
