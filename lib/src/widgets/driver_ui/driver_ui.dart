import 'package:flutter/material.dart';
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
    return HittableStack(
      children: [
        child,
        // TODO: Render the widgets here

        Positioned(
            child: MaterialButton(
          onPressed: viewModel.startSession,
          color: Colors.blue,
          child: Text('Replay Session'),
        ))
      ],
    );
  }

  @override
  DriverUIViewModel viewModelBuilder(BuildContext context) =>
      DriverUIViewModel();
}
