import 'package:json_annotation/json_annotation.dart';
import 'package:eiga_learn/models/TranslationToken.dart';

part 'TranslationUnit.g.dart';

@JsonSerializable()
class TranslationUnit {
  final String id;
  final String finalInput;
  final List<TranslationToken> tokens;
  final Map<String, String>? placeholdersMap;
  final Map<String, dynamic>? meta;

  TranslationUnit({
    required this.id,
    required this.finalInput,
    required this.tokens,
    this.placeholdersMap,
    this.meta,
});

  factory TranslationUnit.fromJson(Map<String, dynamic> json) =>
      _$TranslationUnitFromJson(json);
  Map<String, dynamic> toJson() => _$TranslationUnitToJson(this);
}