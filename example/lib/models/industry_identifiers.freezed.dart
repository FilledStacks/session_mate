// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'industry_identifiers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IndustryIdentifiers _$IndustryIdentifiersFromJson(Map<String, dynamic> json) {
  return _IndustryIdentifiers.fromJson(json);
}

/// @nodoc
mixin _$IndustryIdentifiers {
  String? get type => throw _privateConstructorUsedError;
  String? get idenfifier => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IndustryIdentifiersCopyWith<IndustryIdentifiers> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndustryIdentifiersCopyWith<$Res> {
  factory $IndustryIdentifiersCopyWith(
          IndustryIdentifiers value, $Res Function(IndustryIdentifiers) then) =
      _$IndustryIdentifiersCopyWithImpl<$Res, IndustryIdentifiers>;
  @useResult
  $Res call({String? type, String? idenfifier});
}

/// @nodoc
class _$IndustryIdentifiersCopyWithImpl<$Res, $Val extends IndustryIdentifiers>
    implements $IndustryIdentifiersCopyWith<$Res> {
  _$IndustryIdentifiersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? idenfifier = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      idenfifier: freezed == idenfifier
          ? _value.idenfifier
          : idenfifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IndustryIdentifiersCopyWith<$Res>
    implements $IndustryIdentifiersCopyWith<$Res> {
  factory _$$_IndustryIdentifiersCopyWith(_$_IndustryIdentifiers value,
          $Res Function(_$_IndustryIdentifiers) then) =
      __$$_IndustryIdentifiersCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? type, String? idenfifier});
}

/// @nodoc
class __$$_IndustryIdentifiersCopyWithImpl<$Res>
    extends _$IndustryIdentifiersCopyWithImpl<$Res, _$_IndustryIdentifiers>
    implements _$$_IndustryIdentifiersCopyWith<$Res> {
  __$$_IndustryIdentifiersCopyWithImpl(_$_IndustryIdentifiers _value,
      $Res Function(_$_IndustryIdentifiers) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? idenfifier = freezed,
  }) {
    return _then(_$_IndustryIdentifiers(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      idenfifier: freezed == idenfifier
          ? _value.idenfifier
          : idenfifier // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IndustryIdentifiers extends _IndustryIdentifiers {
  _$_IndustryIdentifiers({this.type, this.idenfifier}) : super._();

  factory _$_IndustryIdentifiers.fromJson(Map<String, dynamic> json) =>
      _$$_IndustryIdentifiersFromJson(json);

  @override
  final String? type;
  @override
  final String? idenfifier;

  @override
  String toString() {
    return 'IndustryIdentifiers(type: $type, idenfifier: $idenfifier)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IndustryIdentifiers &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.idenfifier, idenfifier) ||
                other.idenfifier == idenfifier));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, idenfifier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IndustryIdentifiersCopyWith<_$_IndustryIdentifiers> get copyWith =>
      __$$_IndustryIdentifiersCopyWithImpl<_$_IndustryIdentifiers>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IndustryIdentifiersToJson(
      this,
    );
  }
}

abstract class _IndustryIdentifiers extends IndustryIdentifiers {
  factory _IndustryIdentifiers({final String? type, final String? idenfifier}) =
      _$_IndustryIdentifiers;
  _IndustryIdentifiers._() : super._();

  factory _IndustryIdentifiers.fromJson(Map<String, dynamic> json) =
      _$_IndustryIdentifiers.fromJson;

  @override
  String? get type;
  @override
  String? get idenfifier;
  @override
  @JsonKey(ignore: true)
  _$$_IndustryIdentifiersCopyWith<_$_IndustryIdentifiers> get copyWith =>
      throw _privateConstructorUsedError;
}
