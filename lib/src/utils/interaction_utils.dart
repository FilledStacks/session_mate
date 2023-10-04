class InteractionUtils {
  // static bool visibleOnScreen(UIEvent interaction, Size screenSize) {
  //   final unionSd = interaction.externalities?.reduce((sd, nextSd) {
  //     final result = sd.rect.expandToInclude(nextSd.rect);
  //     return sd.copyWith(
  //         rect: SerializableRect.fromLTWH(
  //             result.left, result.top, result.width, result.height));
  //   });

  //   final visible = unionSd?.rect.contains(
  //       interaction.position.responsiveOffset(screenSize) +
  //           Offset(WIDGET_DESCRIPTION_VISUAL_SIZE / 2,
  //               WIDGET_DESCRIPTION_VISUAL_SIZE / 2));

  //   return visible ?? true;
  // }
}
