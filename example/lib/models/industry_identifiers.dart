import 'package:freezed_annotation/freezed_annotation.dart';

part 'industry_identifiers.freezed.dart';
part 'industry_identifiers.g.dart';

@freezed
class IndustryIdentifiers with _$IndustryIdentifiers {
  IndustryIdentifiers._();

  factory IndustryIdentifiers({
    String? type,
    String? idenfifier,
  }) = _IndustryIdentifiers;

  factory IndustryIdentifiers.fromJson(Map<String, dynamic> json) =>
      _$IndustryIdentifiersFromJson(json);

  factory IndustryIdentifiers.empty() => IndustryIdentifiers(
        type: '',
        idenfifier: '',
      );
}
