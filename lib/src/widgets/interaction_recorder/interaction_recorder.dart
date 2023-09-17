import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  static TextField? _getTappedTextField(_WidgetTreeTraversalData traversalData,
      {bool verbose = false}) {
    TextField? textField;
    final stopwatch = Stopwatch()..start();

    void visitor(Element element) {
      if (element.widget is TextField) {
        final textFieldWidget = element.widget as TextField;
        final renderBox = element.findRenderObject() as RenderBox;
        if (verbose) {
          print('⏰ FindRenderObject executed in - ${stopwatch.elapsed}');
        }
        final pos = renderBox.localToGlobal(Offset.zero);

        if (verbose) {
          print('⏰ localToGlobal executed in - ${stopwatch.elapsed}');
        }

        final textFieldRect = Rect.fromLTWH(
          pos.dx,
          pos.dy,
          renderBox.size.width,
          renderBox.size.height,
        );

        if (textFieldRect.contains(traversalData.touchPoint)) {
          textField = textFieldWidget;
        }

        if (verbose) {
          print('⏰ contains executed in - ${stopwatch.elapsed}');
        }
      }

      if (textField == null) {
        element.visitChildren(visitor);
      } else {
        // print('TextField found, time to return!!');
      }
    }

    traversalData.context.visitChildElements(visitor);
    if (verbose) {
      print('⏰ Traversal time - ${stopwatch.elapsed}');
    }

    return textField;
  }

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

    return Stack(
      children: [
        NotificationListener(
          onNotification: (Notification notification) {
            viewModel.onChildNotification(notification);

            // TODO (Refactor): This can be moved out of here into a place wr
            // can unit test it's behaviour
            if (viewModel.lastTapPosition == null) {
              // print(
              //     'There is no tap position so we cannot possible have an input event');
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
