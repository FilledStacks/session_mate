// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_interaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInteraction _$$_UserInteractionFromJson(Map<String, dynamic> json) =>
    _$_UserInteraction(
      position: _$recordConvert(
        json['position'],
        ($jsonValue) => (
          ($jsonValue[r'$1'] as num).toDouble(),
          ($jsonValue[r'$2'] as num).toDouble(),
        ),
      ),
      type: $enumDecode(_$InteractionTypeEnumMap, json['type']),
      inputData: json['inputData'] as String?,
    );

Map<String, dynamic> _$$_UserInteractionToJson(_$_UserInteraction instance) =>
    <String, dynamic>{
      'position': {
        r'$1': instance.position.$1,
        r'$2': instance.position.$2,
      },
      'type': _$InteractionTypeEnumMap[instance.type]!,
      'inputData': instance.inputData,
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);

const _$InteractionTypeEnumMap = {
  InteractionType.tap: 'tap',
  InteractionType.input: 'input',
  InteractionType.scrollUp: 'scrollUp',
  InteractionType.scrollDown: 'scrollDown',
  InteractionType.scrollLeft: 'scrollLeft',
  InteractionType.scrollRight: 'scrollRight',
  InteractionType.longTap: 'longTap',
  InteractionType.pinchOut: 'pinchOut',
  InteractionType.pinchIn: 'pinchIn',
};
