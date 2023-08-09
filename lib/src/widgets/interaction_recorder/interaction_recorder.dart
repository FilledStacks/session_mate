import 'package:flutter/material.dart';
import 'package:session_mate/src/enums/interaction_type.dart';
import 'package:session_mate/src/widgets/custom_gesture_detector.dart';
import 'package:session_mate/src/widgets/interaction_recorder/interaction_recorder_viewmodel.dart';
import 'package:stacked/stacked.dart';

class InteractionRecorder extends StackedView<InteractionRecorderViewModel> {
  final Widget child;
  const InteractionRecorder({Key? key, required this.child}) : super(key: key);

  static TextField _getTappedTextField({
    required BuildContext context,
    required Offset touchPoint,
  }) {
    TextField? textField;

    void visitor(Element element) {
      // print(
      //   ' ============ Element details: Type-${element.runtimeType} ===========');
      if (element.widget is TextField) {
        final textFieldWidget = element.widget as TextField;
        final renderBox = element.findRenderObject() as RenderBox;
        final pos = renderBox.localToGlobal(Offset.zero);

        final textFieldRect = Rect.fromLTWH(
            pos.dx, pos.dy, renderBox.size.width, renderBox.size.height);

        print('======== text field bounds: $textFieldRect =======');

        if (textFieldRect.contains(touchPoint)) {
          textField = textFieldWidget;
        }
      }
      if (textField == null) {
        element.visitChildren(visitor);
      } else {
        print('TextField found, time to return!!');
      }
    }

    context.visitChildElements(visitor);

    return textField!;
  }

  @override
  Widget builder(
    BuildContext context,
    InteractionRecorderViewModel viewModel,
    Widget? child,
  ) {
    return Stack(
      children: [
        NotificationListener<KeepAliveNotification>(
          onNotification: (_) {
            final textField = _getTappedTextField(
              context: context,
              touchPoint: Offset(
                viewModel.activeCommand?.position.$1 ?? 0,
                viewModel.activeCommand?.position.$2 ?? 0,
              ),
            );

            viewModel.updateActiveCommand(type: InteractionType.input);
            if (textField.controller == null) {
              throw Exception(
                'SessionMate: All your text input controllers should have a text editing controller, otherwise we cannot identify input',
              );
            }
            viewModel.updateInputCommandDetails(
              inputFieldController: textField.controller!,
            );
            return false;
          },
          child: CustomGestureDetector(
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
        ),
      ],
    );
  }

  @override
  InteractionRecorderViewModel viewModelBuilder(BuildContext context) {
    return InteractionRecorderViewModel();
  }
}
