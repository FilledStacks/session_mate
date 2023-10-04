import 'dart:ui';

import 'package:session_mate/src/extensions/event_extensions.dart';
import 'package:session_mate/src/extensions/ui_extensions.dart';
import 'package:session_mate/src/package_constants.dart';
import 'package:session_mate_core/session_mate_core.dart';

class InteractionUtils {
  static bool visibleOnScreen(UIEvent interaction, Size screenSize) {
    final unionSd = interaction.externalities?.reduce((sd, nextSd) {
      final result = sd.rect.asRect.expandToInclude(nextSd.rect.asRect);
      return sd.copyWith(
        rect: ScrollableRect(
          result.left,
          result.top,
          result.width,
          result.height,
        ),
      );
    });

    // TODO (Feature): Add responsive positioning here
    final visible = unionSd?.rect.asRect.contains(
      interaction.position.asOffset +
          Offset(kEventVisualSize / 2, kEventVisualSize / 2),
    );

    return visible ?? true;
  }
}
