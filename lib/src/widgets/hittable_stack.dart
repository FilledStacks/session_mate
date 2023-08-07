import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HittableStack extends Stack {
  final Function(Offset) onUserTap;

  const HittableStack({
    super.key,
    super.children,
    required this.onUserTap,
  });

  @override
  CustomRenderStack createRenderObject(BuildContext context) {
    return CustomRenderStack(
      alignment: alignment,
      textDirection: textDirection ?? Directionality.of(context),
      fit: fit,
      clipBehavior: clipBehavior,
      userTap: onUserTap,
    );
  }
}

class CustomRenderStack extends RenderStack {
  final Function(Offset) userTap;
  CustomRenderStack({
    alignment,
    textDirection,
    fit,
    clipBehavior,
    required this.userTap,
  }) : super(
          alignment: alignment,
          textDirection: textDirection,
          fit: fit,
          clipBehavior: clipBehavior,
        );

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    var stackHit = false;

    // userTap(position);

    final children = getChildrenAsList();

    for (var child in children) {
      final StackParentData? childParentData =
          child.parentData as StackParentData?;

      final childHit = result.addWithPaintOffset(
        offset: childParentData?.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed ==
              position - (childParentData?.offset ?? Offset.zero));
          return child.hitTest(result, position: transformed);
        },
      );

      if (childHit) stackHit = true;
    }

    return stackHit;
  }
}
