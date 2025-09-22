// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TranslationToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationToken _$TranslationTokenFromJson(Map<String, dynamic> json) =>
    TranslationToken(
      surface: json['surface'] as String,
      reading: json['reading'] as String? ?? '',
      lemma: json['lemma'] as String? ?? '',
      candidates: (json['candidates'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      type: json['type'] as String? ?? 'word',
    );

Map<String, dynamic> _$TranslationTokenToJson(TranslationToken instance) =>
    <String, dynamic>{
      'surface': instance.surface,
      'reading': instance.reading,
      'lemma': instance.lemma,
      'candidates': instance.candidates,
      'type': instance.type,
    };
