import 'package:flutter/material.dart';
import 'package:gesture_x_detector/gesture_x_detector.dart';
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
    return Stack(
      children: [
        XGestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: (tapDetails) => viewModel.onUserTap(
            tapDetails.position,
          ),
          onScrollEvent: (scrollEvent) => viewModel.onScrollEvent(
              scrollEvent.position, scrollEvent.scrollDelta),
          onMoveStart: (event) => viewModel.onMoveStart(event.position),
          onMoveEnd: (event) => viewModel.onMoveEnd(event.position),
          child: this.child,
        ),
      ],
    );
  }

  @override
  InteractionRecorderViewModel viewModelBuilder(BuildContext context) {
    return InteractionRecorderViewModel();
  }
}
