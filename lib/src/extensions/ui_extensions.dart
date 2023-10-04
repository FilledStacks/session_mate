import 'dart:ui';

import 'package:session_mate_core/session_mate_core.dart';

extension RectangleExtension on ScrollableRect {
  Rect get asRect {
    return Rect.fromLTWH(left, top, width, height);
  }
}
