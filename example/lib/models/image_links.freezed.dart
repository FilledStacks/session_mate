// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_links.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ImageLinks _$ImageLinksFromJson(Map<String, dynamic> json) {
  return _ImageLinks.fromJson(json);
}

/// @nodoc
mixin _$ImageLinks {
  String get smallThumbnail => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageLinksCopyWith<ImageLinks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageLinksCopyWith<$Res> {
  factory $ImageLinksCopyWith(
          ImageLinks value, $Res Function(ImageLinks) then) =
      _$ImageLinksCopyWithImpl<$Res, ImageLinks>;
  @useResult
  $Res call({String smallThumbnail, String thumbnail});
}

/// @nodoc
class _$ImageLinksCopyWithImpl<$Res, $Val extends ImageLinks>
    implements $ImageLinksCopyWith<$Res> {
  _$ImageLinksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smallThumbnail = null,
    Object? thumbnail = null,
  }) {
    return _then(_value.copyWith(
      smallThumbnail: null == smallThumbnail
          ? _value.smallThumbnail
          : smallThumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageLinksCopyWith<$Res>
    implements $ImageLinksCopyWith<$Res> {
  factory _$$_ImageLinksCopyWith(
          _$_ImageLinks value, $Res Function(_$_ImageLinks) then) =
      __$$_ImageLinksCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String smallThumbnail, String thumbnail});
}

/// @nodoc
class __$$_ImageLinksCopyWithImpl<$Res>
    extends _$ImageLinksCopyWithImpl<$Res, _$_ImageLinks>
    implements _$$_ImageLinksCopyWith<$Res> {
  __$$_ImageLinksCopyWithImpl(
      _$_ImageLinks _value, $Res Function(_$_ImageLinks) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? smallThumbnail = null,
    Object? thumbnail = null,
  }) {
    return _then(_$_ImageLinks(
      smallThumbnail: null == smallThumbnail
          ? _value.smallThumbnail
          : smallThumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ImageLinks extends _ImageLinks {
  _$_ImageLinks({required this.smallThumbnail, required this.thumbnail})
      : super._();

  factory _$_ImageLinks.fromJson(Map<String, dynamic> json) =>
      _$$_ImageLinksFromJson(json);

  @override
  final String smallThumbnail;
  @override
  final String thumbnail;

  @override
  String toString() {
    return 'ImageLinks(smallThumbnail: $smallThumbnail, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageLinks &&
            (identical(other.smallThumbnail, smallThumbnail) ||
                other.smallThumbnail == smallThumbnail) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, smallThumbnail, thumbnail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageLinksCopyWith<_$_ImageLinks> get copyWith =>
      __$$_ImageLinksCopyWithImpl<_$_ImageLinks>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ImageLinksToJson(
      this,
    );
  }
}

abstract class _ImageLinks extends ImageLinks {
  factory _ImageLinks(
      {required final String smallThumbnail,
      required final String thumbnail}) = _$_ImageLinks;
  _ImageLinks._() : super._();

  factory _ImageLinks.fromJson(Map<String, dynamic> json) =
      _$_ImageLinks.fromJson;

  @override
  String get smallThumbnail;
  @override
  String get thumbnail;
  @override
  @JsonKey(ignore: true)
  _$$_ImageLinksCopyWith<_$_ImageLinks> get copyWith =>
      throw _privateConstructorUsedError;
}
