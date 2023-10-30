import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:session_mate/src/widgets/custom_gesture_detector.dart';
import 'package:session_mate/src/widgets/interaction_recorder/interaction_recorder_viewmodel.dart';
import 'package:session_mate_core/session_mate_core.dart' as core;
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
    return Stack(
      children: [
        NotificationListener(
          onNotification: viewModel.onChildNotification,
          child: CustomGestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (event) => viewModel.onUserTap(
              position: event.position,
            ),
            onMoveStart: (event) => viewModel.onDragStart(event.position),
            onMoveEnd: (event) => viewModel.onDragEnd(event.position),
            child: this.child,
          ),
        ),
      ],
    );
  }

  @override
  void onViewModelReady(InteractionRecorderViewModel viewModel) {
    RawKeyboard.instance.addListener((keyEvent) {
      if (keyEvent is RawKeyUpEvent) {
        if (keyEvent.logicalKey == LogicalKeyboardKey.goBack) {
          viewModel.onRawKeyEvent(type: core.InteractionType.backPressEvent);
        }
      }
    });
  }

  @override
  InteractionRecorderViewModel viewModelBuilder(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return InteractionRecorderViewModel(
      screenSize: size,
      devicePixelRatio: devicePixelRatio,
    );
  }
}
