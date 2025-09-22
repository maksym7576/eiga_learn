

import 'dart:math';

import 'package:eiga_learn/models/TranslationUnit.dart';
import 'package:eiga_learn/providers/ServicesProviders.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextPreparingService {
  final Ref ref;
  final int chunkSize;

  TextPreparingService ({required this.ref, this.chunkSize = 4096});

  Future<List<TranslationUnit>> srtDepack({required String srtPath, required String videoId, bool usePlaceholders = true}) async {
    final srt = ref.read(srtDepakerServiceProvider);
    final preproc = ref.read(preprocessorServiceProvider);
    final cache = ref.read(hiveCacheServiceProvider);
    final rawSubs = await srt.processSetToSubtitles(
        srtPath: srtPath, videoId: videoId);
    final List<TranslationUnit> units = [];
    for (final sub in rawSubs) {
      final cacheKey = 'pre_${videoId}_${sub.index}_${sub.startTime!
          .inMilliseconds}';
      final cached = await cache.get<TranslationUnit>(cacheKey);
      if (cached != null) {
        units.add(cached);
        continue;
      }

      final preResult = await preproc.process(sub.wordsJP ?? '');

      final chunks = _chunkText(preResult.finalText, chunkSize);
      for (int i = 0; i < chunks.length; i++) {
        final unitId = '${videoId}_${sub.index}_$i';
        final unit = TranslationUnit(
          id: unitId,
          finalInput: chunks[i],
          tokens: preResult.tokens,
          placeholdersMap: preResult.placeholdersMap,
          meta: {
            // Assuming this is where usePlaceholders or other meta data goes.
            // Complete based on your needs, e.g., 'usePlaceholders': usePlaceholders,
          },
        );
        units.add(unit);
      }
    }
    return units;
  }

  List<String> _chunkText(String text, int size) {
    final List<String> chunks = [];
    for (int i = 0; i < text.length; i += size) {
      chunks.add(text.substring(i, min(i + size, text.length)));
    }
    return chunks;
  }
}