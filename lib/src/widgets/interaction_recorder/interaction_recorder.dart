import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:session_mate/src/widgets/custom_gesture_detector.dart';
import 'package:session_mate/src/widgets/interaction_recorder/interaction_recorder_viewmodel.dart';
import 'package:stacked/stacked.dart';

class InteractionRecorder extends StackedView<InteractionRecorderViewModel> {
  final Widget child;
  const InteractionRecorder({Key? key, required this.child}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InteractionRecorderViewModel viewModel,
    Widget? child,
  ) {
    RawKeyboard.instance.addListener((keyEvent) {
      if (keyEvent is RawKeyUpEvent) {
        if (keyEvent.logicalKey == LogicalKeyboardKey.goBack) {
          viewModel.onRawKeyEvent(
            keyId: keyEvent.logicalKey.keyId,
            keyLabel: keyEvent.logicalKey.keyLabel,
            usbHidUsage: keyEvent.physicalKey.usbHidUsage,
          );
        }
      }
    });

    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        NotificationListener(
          onNotification: viewModel.onChildNotification,
          child: CustomGestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (event) =>
                viewModel.onUserTap(position: event.position, screenSize: size),
            child: this.child,
          ),
        ),
      ],
    );
  }

  @override
  InteractionRecorderViewModel viewModelBuilder(BuildContext context) {
    return InteractionRecorderViewModel();
  }
}
