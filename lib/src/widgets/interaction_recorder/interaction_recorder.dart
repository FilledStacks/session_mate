import 'package:flutter/material.dart';
import 'package:session_mate/src/widgets/custom_gesture_detector.dart';
import 'package:session_mate/src/widgets/interaction_recorder/interaction_recorder_viewmodel.dart';
import 'package:stacked/stacked.dart';

class _WidgetTreeTraversalData {
  final BuildContext context;
  final Offset touchPoint;

  _WidgetTreeTraversalData({required this.context, required this.touchPoint});
}

class InteractionRecorder extends StackedView<InteractionRecorderViewModel> {
  final Widget child;
  const InteractionRecorder({Key? key, required this.child}) : super(key: key);

  static TextField? _getTappedTextField(
    _WidgetTreeTraversalData traversalData,
  ) {
    TextField? textField;
    final stopwatch = Stopwatch()..start();

    void visitor(Element element) {
      // print(
      //   ' ============ Element details: Type-${element.runtimeType} ===========');

      if (element.widget is TextField) {
        final textFieldWidget = element.widget as TextField;
        final renderBox = element.findRenderObject() as RenderBox;
        print('⏰ FindRenderObject executed in - ${stopwatch.elapsed}');
        final pos = renderBox.localToGlobal(Offset.zero);

        print('⏰ localToGlobal executed in - ${stopwatch.elapsed}');

        final textFieldRect = Rect.fromLTWH(
          pos.dx,
          pos.dy,
          renderBox.size.width,
          renderBox.size.height,
        );

        if (textFieldRect.contains(traversalData.touchPoint)) {
          textField = textFieldWidget;
        }

        print('⏰ contains executed in - ${stopwatch.elapsed}');
      }

      if (textField == null) {
        element.visitChildren(visitor);
      } else {
        print('TextField found, time to return!!');
      }
    }

    traversalData.context.visitChildElements(visitor);
    print('⏰ Traversal time - ${stopwatch.elapsed}');

    return textField;
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
            if (viewModel.lastTapPosition == null) {
              print(
                  'There is no tap position so we cannot possible have an input event');
              return false;
            }

            final textField = _getTappedTextField(_WidgetTreeTraversalData(
              context: context,
              touchPoint: Offset(
                viewModel.lastTapPosition?.dx ?? 0,
                viewModel.lastTapPosition?.dy ?? 0,
              ),
            ));

            final interactionWithTextField = textField != null;

            if (interactionWithTextField) {
              if (textField.controller == null) {
                throw Exception(
                  'SessionMate: All your text input controllers should have a text editing controller, otherwise we cannot identify input',
                );
              }
              viewModel.addInputCommand(
                inputController: textField.controller!,
              );
            }

            return false;
          },
          child: CustomGestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (event) => viewModel.onUserTap(event.position),
            onScrollEvent: (event) => viewModel.onScrollEvent(
              event.position,
              event.scrollDelta,
            ),
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
