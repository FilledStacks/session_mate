// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_scroll_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ActiveScrollMetrics {
  double get startingOffset => throw _privateConstructorUsedError;
  Axis get scrollDirection => throw _privateConstructorUsedError;
  Offset get scrollOrigin => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActiveScrollMetricsCopyWith<ActiveScrollMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveScrollMetricsCopyWith<$Res> {
  factory $ActiveScrollMetricsCopyWith(
          ActiveScrollMetrics value, $Res Function(ActiveScrollMetrics) then) =
      _$ActiveScrollMetricsCopyWithImpl<$Res, ActiveScrollMetrics>;
  @useResult
  $Res call({double startingOffset, Axis scrollDirection, Offset scrollOrigin});
}

/// @nodoc
class _$ActiveScrollMetricsCopyWithImpl<$Res, $Val extends ActiveScrollMetrics>
    implements $ActiveScrollMetricsCopyWith<$Res> {
  _$ActiveScrollMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startingOffset = null,
    Object? scrollDirection = null,
    Object? scrollOrigin = null,
  }) {
    return _then(_value.copyWith(
      startingOffset: null == startingOffset
          ? _value.startingOffset
          : startingOffset // ignore: cast_nullable_to_non_nullable
              as double,
      scrollDirection: null == scrollDirection
          ? _value.scrollDirection
          : scrollDirection // ignore: cast_nullable_to_non_nullable
              as Axis,
      scrollOrigin: null == scrollOrigin
          ? _value.scrollOrigin
          : scrollOrigin // ignore: cast_nullable_to_non_nullable
              as Offset,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActiveScrollMetricsImplCopyWith<$Res>
    implements $ActiveScrollMetricsCopyWith<$Res> {
  factory _$$ActiveScrollMetricsImplCopyWith(_$ActiveScrollMetricsImpl value,
          $Res Function(_$ActiveScrollMetricsImpl) then) =
      __$$ActiveScrollMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double startingOffset, Axis scrollDirection, Offset scrollOrigin});
}

/// @nodoc
class __$$ActiveScrollMetricsImplCopyWithImpl<$Res>
    extends _$ActiveScrollMetricsCopyWithImpl<$Res, _$ActiveScrollMetricsImpl>
    implements _$$ActiveScrollMetricsImplCopyWith<$Res> {
  __$$ActiveScrollMetricsImplCopyWithImpl(_$ActiveScrollMetricsImpl _value,
      $Res Function(_$ActiveScrollMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startingOffset = null,
    Object? scrollDirection = null,
    Object? scrollOrigin = null,
  }) {
    return _then(_$ActiveScrollMetricsImpl(
      startingOffset: null == startingOffset
          ? _value.startingOffset
          : startingOffset // ignore: cast_nullable_to_non_nullable
              as double,
      scrollDirection: null == scrollDirection
          ? _value.scrollDirection
          : scrollDirection // ignore: cast_nullable_to_non_nullable
              as Axis,
      scrollOrigin: null == scrollOrigin
          ? _value.scrollOrigin
          : scrollOrigin // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc

class _$ActiveScrollMetricsImpl implements _ActiveScrollMetrics {
  _$ActiveScrollMetricsImpl(
      {required this.startingOffset,
      required this.scrollDirection,
      required this.scrollOrigin});

  @override
  final double startingOffset;
  @override
  final Axis scrollDirection;
  @override
  final Offset scrollOrigin;

  @override
  String toString() {
    return 'ActiveScrollMetrics(startingOffset: $startingOffset, scrollDirection: $scrollDirection, scrollOrigin: $scrollOrigin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveScrollMetricsImpl &&
            (identical(other.startingOffset, startingOffset) ||
                other.startingOffset == startingOffset) &&
            (identical(other.scrollDirection, scrollDirection) ||
                other.scrollDirection == scrollDirection) &&
            (identical(other.scrollOrigin, scrollOrigin) ||
                other.scrollOrigin == scrollOrigin));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, startingOffset, scrollDirection, scrollOrigin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveScrollMetricsImplCopyWith<_$ActiveScrollMetricsImpl> get copyWith =>
      __$$ActiveScrollMetricsImplCopyWithImpl<_$ActiveScrollMetricsImpl>(
          this, _$identity);
}

abstract class _ActiveScrollMetrics implements ActiveScrollMetrics {
  factory _ActiveScrollMetrics(
      {required final double startingOffset,
      required final Axis scrollDirection,
      required final Offset scrollOrigin}) = _$ActiveScrollMetricsImpl;

  @override
  double get startingOffset;
  @override
  Axis get scrollDirection;
  @override
  Offset get scrollOrigin;
  @override
  @JsonKey(ignore: true)
  _$$ActiveScrollMetricsImplCopyWith<_$ActiveScrollMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
