import 'package:flutter/material.dart';
import 'package:session_mate/src/app/logger.dart';
import 'package:session_mate/src/enums/interaction_type.dart';
import 'package:session_mate/src/models/user_interaction.dart';
import 'package:stacked/stacked.dart';

typedef TapPosition = (double, double);

class InteractionRecorderViewModel extends BaseViewModel {
  final log = getLogger('InteractionRecorderViewModel');

  List<UserInteraction> userInteractions = [];

  void onUserTap(Offset position) {
    log.i('position:$position');

    userInteractions.add(UserInteraction(
      position: (position.dx, position.dy),
      type: InteractionType.tap,
    ));
  }

  void onScrollEvent(
    Offset position,
    Offset scrollDelta,
  ) {
    log.i('postion: $position, scrollDelta: $scrollDelta');
  }

  void onMoveStart(Offset position) {
    log.i('postion: $position');
  }

  void onMoveEnd(Offset position) {
    log.i('postion: $position');
  }
}
