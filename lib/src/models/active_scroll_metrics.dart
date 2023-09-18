import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_scroll_metrics.freezed.dart';

/// This model should not go to session_mate_core because it's not to be used
/// outside of this package. It relies on the Flutter framework types.

@freezed
class ActiveScrollMetrics with _$ActiveScrollMetrics {
  factory ActiveScrollMetrics({
    required double startingOffset,
    required Axis scrollDirection,
    required Offset scrollOrigin,
  }) = _ActiveScrollMetrics;
}
