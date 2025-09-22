// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TranslationUnit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationUnit _$TranslationUnitFromJson(Map<String, dynamic> json) =>
    TranslationUnit(
      id: json['id'] as String,
      finalInput: json['finalInput'] as String,
      tokens: (json['tokens'] as List<dynamic>)
          .map((e) => TranslationToken.fromJson(e as Map<String, dynamic>))
          .toList(),
      placeholdersMap: (json['placeholdersMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      meta: json['meta'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$TranslationUnitToJson(TranslationUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'finalInput': instance.finalInput,
      'tokens': instance.tokens,
      'placeholdersMap': instance.placeholdersMap,
      'meta': instance.meta,
    };
