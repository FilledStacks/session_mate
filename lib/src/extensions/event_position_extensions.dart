import 'package:flutter/material.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate_core/session_mate_core.dart';

extension WidgetPositionExtension on EventPosition {
  Offset get toOffset => Offset(x, y);
  EventPosition withScrollable(ScrollableDescription scrollable) {
    final scrollingPixels = scrollable.scrollOffsetInPixels;

    if (scrollable.axis == ScrollAxis.vertical) {
      return copyWith(x: x, y: y + scrollingPixels);
    } else {
      return copyWith(x: x + scrollingPixels, y: y);
    }
  }

  EventPosition applyScroll(ScrollableDescription scrollableDescription) {
    switch (scrollableDescription.axis) {
      case ScrollAxis.vertical:
        return copyWith(yDeviation: scrollableDescription.scrollOffsetInPixels);
      case ScrollAxis.horizontal:
        return copyWith(xDeviation: scrollableDescription.scrollOffsetInPixels);
    }
  }

  Offset responsiveOffset(Size screenSize) {
    final responsiveWidth = responsiveXPosition(screenSize.width);
    final responsiveHeight = responsiveYPosition(screenSize.height);
    return Offset(responsiveWidth, responsiveHeight);
  }

  double responsiveXPosition(double currentScreenWidth) {
    final result = _calculateWidthRatio(currentScreenWidth) * x +
        xDeviation -
        (kEventVisualSize / 2);
    return result;
  }

  double responsiveYPosition(double currentScreenHeight) {
    final result = _calculateHeightRatio(currentScreenHeight) * y +
        yDeviation -
        (kEventVisualSize / 2);
    return result;
  }

  double _calculateHeightRatio(double currentScreenHeight) {
    /// If the [capturedDeviceHeight] is null or 0 return 1
    /// which will leave the original hight unchanged
    if (capturedDeviceHeight == 0) {
      return 1;
    } else {
      return currentScreenHeight / capturedDeviceHeight;
    }
  }

  double _calculateWidthRatio(double currentScreenWidth) {
    /// If the [capturedDeviceHeight] is null or 0 return 1
    /// which will leave the original width unchanged
    if (capturedDeviceWidth == 0) {
      return 1;
    } else {
      return currentScreenWidth / capturedDeviceWidth;
    }
  }
}
