

import 'package:eiga_learn/models/TranslationToken.dart';
import 'package:flutter/cupertino.dart';

class PreprocResult{
  final String finalText;
  final List<TranslationToken> tokens;
  final Map<String, String>? placeholdersMap;

  PreprocResult({required this.finalText, required this.tokens, this.placeholdersMap});
}

class PreprocessorService {
  final bool usePlaceholders;

  PreprocessorService({this.usePlaceholders = true});

  Future<PreprocResult> process(String raw, {int maxLen = 4096}) async {
    String s = _normalizeRawText(raw.trim());
    s = _stripTagsAndControls(s);
    s = s.characters.toString().trim();
    // 4) Токенізація — тут виклик MeCab або простий fallback
    final tokens = await _tokenize(s);
    // 5) JMdict lookup — тут Заглушка (повинна бути батч-запит у реалі)
    final tokensWithCandidates = await _jmLookup(tokens);
    // 6) Placeholdering
    Map<String, String>? phMap;
    if (usePlaceholders) {
      final ph = _createPlaceholders(tokensWithCandidates);
      phMap = ph.placeholdersMap;
      s = ph.replacedText;
    }

    // 7) Truncate to model limit (chars)
    if (s.length > maxLen) s = s.substring(0, maxLen);

    return PreprocResult(finalText: s, tokens: tokensWithCandidates, placeholdersMap: phMap);
  }


  String _normalizeRawText(String s) {
    s = s.replaceAll('\u3000', ' ');
    for (int i = 0; i <= 9; i++) {
      final fw = String.fromCharCode(0xFF10 + i);
      s = s.replaceAll(fw, i.toString());
    }
    s = s.replaceAll(RegExp(r'[\u00A0\u1680\u2000-\u200A\u202F\u205F]+'), ' ');
    s = s.replaceAll(RegExp(r'\s+'), ' ');
    s = s.replaceAll('･', '・');
    s = s.replaceAll('〜', '');
    s = s.trim();
    return s;
  }

  String _stripTagsAndControls(String s) {
    s = s.replaceAll(RegExp(r'\{\\[^}]+\}'), '');
    s = s.replaceAll(RegExp(r'<[^>]+>'), '');
    s = s.replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '');
    return s;
  }

  Future<List<TranslationToken>> _tokenize(String s) async {
    // Тут потрібно підключити MeCab (локальний пакет або microservice)
    // Для прикладу — простий whitespace fallback, і return minimal token info
    final parts = s.split(RegExp(r'\s+'));
    return parts.where((p) => p.isNotEmpty).map((p) => TranslationToken(surface: p)).toList();
  }

  Future<List<TranslationToken>> _jmLookup(List<TranslationToken> tokens) async {
    // Заглушка: в реалі зробити пошук у sqlite або jmDict map
    return tokens.map((t) => t).toList();
  }

  _PlaceholderResult _createPlaceholders(List<TranslationToken> tokens) {
    final Map<String, String> map = {};
    String replacedText = tokens.map((t) => t.surface).join(' ');

    int counter = 0;
    final pattern = RegExp(r'(https?:\/\/[^\s]+)|([0-9]+)|([\p{Emoji}])', unicode: true);

    replacedText = replacedText.replaceAllMapped(pattern, (m) {
      counter++;
      final key = '__PH_\$counter__';
      map[key] = m.group(0)!;
      return key;
    });

    return _PlaceholderResult(placeholdersMap: map, replacedText: replacedText);
  }
}

class _PlaceholderResult {
  final Map<String, String> placeholdersMap;
  final String replacedText;
  _PlaceholderResult({required this.placeholdersMap, required this.replacedText});
}

