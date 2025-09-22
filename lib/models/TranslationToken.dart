import 'package:json_annotation/json_annotation.dart';

part 'TranslationToken.g.dart';

@JsonSerializable()
class TranslationToken {
    final String surface;
    final String reading;
    final String lemma;
    List<String>? candidates;
    final String type;

    TranslationToken({
      required this.surface,
      this.reading = '',
      this.lemma = '',
      this.candidates,
      this.type = 'word',
});

    TranslationToken copyWith({
      String? surface,
      String? lemma,
      String? reading,
      String? type,
      List<String>? candidates,
    }) {
      return TranslationToken(
        surface: surface ?? this.surface,
        lemma: lemma ?? this.lemma,
        reading: reading ?? this.reading,
        type: type ?? this.type,
        candidates: candidates ?? this.candidates,
      );
    }

    factory TranslationToken.fromJson(Map<String, dynamic> json) =>
        _$TranslationTokenFromJson(json);
    Map<String, dynamic> toJson() => _$TranslationTokenToJson(this);
}