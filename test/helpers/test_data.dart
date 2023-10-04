import 'package:session_mate_core/session_mate_core.dart';

final kTopLeftVerticalScrollableDescription = ScrollableDescription(
    axis: ScrollAxis.vertical,
    maxScrollExtentByPixels: 0,
    scrollOffsetInPixels: 100,
    rect: ScrollableRect(0, 0, 22, 22));

final kFullScreenVerticalScrollableDescription = ScrollableDescription(
    axis: ScrollAxis.vertical,
    maxScrollExtentByPixels: 2000,
    scrollOffsetInPixels: 150,
    rect: ScrollableRect(0, 0, 400, 900));

final kTopLeftHorizontalScrollableDescription = ScrollableDescription(
    axis: ScrollAxis.horizontal,
    maxScrollExtentByPixels: 0,
    scrollOffsetInPixels: 50,
    rect: ScrollableRect(0, 20, 40, 40));
