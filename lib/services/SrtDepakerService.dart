import 'dart:io';

import 'package:eiga_learn/models/SubtitleObject.dart';

class SrtDepakerService {

  Future<List<SubtitleObject>> processSetToSubtitles({ required String srtPath, required String videoId,}) async {
    final content = await _readSrtFile(srtPath);
    if(content.isEmpty) return [];
    return await _parseSrtContent(content, videoId);
  }

  Future<String> _readSrtFile(String srtPath) async {
    final file = File(srtPath);
    if (!file.existsSync()) return '';
    return file.readAsStringSync();
  }

  Future<List<SubtitleObject>> _parseSrtContent(String content, String videoId) async {
    final List<SubtitleObject> subtitles = [];
    final blocks = content.trim().split(RegExp(r'\r?\n\r?\n'));
    for (final block in blocks) {
      final lines = block.trim().split(RegExp(r'\r?\n'));
      if (lines.length >= 2) {
        final index = int.tryParse(lines[0].trim());
        final timeRange = lines[1];
        final rawText = lines.sublist(2).join('\n');
        final times = timeRange.split(' --> ');
        if (times.length == 2) {
          final start = await _parseTime(times[0]);
          final end = await _parseTime(times[1]);
          subtitles.add(SubtitleObject(
            index: index ?? 0,
            startTime: start,
            endTime: end,
            wordsJP: rawText,
            translation: null,
            videoId: videoId,
            isActive: false,
          ));
        }
      }
    }
    return subtitles;
  }

  Future<Duration> _parseTime(String timeString) async {
    final parts = timeString.trim().split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    final secondsAndMillis = parts[2].split(',');
    final seconds = int.parse(secondsAndMillis[0]);
    final milliseconds = int.parse(secondsAndMillis[1]);
    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }
}
