import 'dart:ui';

import 'package:session_mate/src/common/app_colors.dart';
import 'package:session_mate_core/session_mate_core.dart';

extension RectangleExtension on ScrollableRect {
  Rect get asRect {
    return Rect.fromLTWH(left, top, width, height);
  }
}

extension TypeToColor on InteractionType {
  Color get toColor {
    switch (this) {
      case InteractionType.tap:
        return kcTapPink;

      case InteractionType.input:
        return kcInputYellow;

      case InteractionType.scroll:
        return kcScrollableGreen;

      case InteractionType.drag:
        return kcDragRed;

      default:
        return Color(0xffffffff);
    }
  }
}
