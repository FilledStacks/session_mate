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
        Positioned(
          bottom: 50,
          left: MediaQuery.of(context).size.width / 2 - 40,
          child: MaterialButton(
            minWidth: 80,
            onPressed: viewModel.startSession,
            color: Colors.blue,
            child: Text('Replay Session'),
          ),
        )
      ],
    );
  }

  @override
  DriverUIViewModel viewModelBuilder(BuildContext context) =>
      DriverUIViewModel();
}
