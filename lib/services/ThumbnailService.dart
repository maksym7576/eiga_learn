import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';

class ThumbnailService {
  static const String ffmpegAssetPath = 'assets/ffmpeg/ffmpeg.exe';

  Future<String> generateThumbnail(String videoPath, {double timeSeconds = 5.0}) async {
    if (kIsWeb) {
      throw UnsupportedError('Web is not supported for thumbnail generation.');
    }

    if (Platform.isWindows) {
      return await _generateThumbnailWindows(videoPath, timeSeconds: timeSeconds);
    } else if (Platform.isAndroid || Platform.isIOS) {
      return await _generateThumbnailMobile(videoPath, timeSeconds: timeSeconds);
    } else if (Platform.isMacOS || Platform.isLinux) {
      return await _generateThumbnailDesktopUnix(videoPath, timeSeconds: timeSeconds);
    } else {
      throw UnsupportedError('Platform not supported for thumbnail generation.');
    }
  }

  Future<String> _generateThumbnailWindows(String videoPath, {double timeSeconds = 5.0}) async {
    final tempDir = await getTemporaryDirectory();
    final ffmpegFile = File(p.join(tempDir.path, 'ffmpeg.exe'));

    if (!ffmpegFile.existsSync()) {
      try {
        final data = await rootBundle.load(ffmpegAssetPath);
        final bytes = data.buffer.asUint8List();
        await ffmpegFile.writeAsBytes(bytes, flush: true);
      } catch (e) {
        final alt = File(p.join(Directory.current.path, 'ffmpeg', Platform.isWindows ? 'ffmpeg.exe' : 'ffmpeg'));
        if (await alt.exists()) {
          await alt.copy(ffmpegFile.path);
        } else {
          throw Exception('ffmpeg not found in assets and not present near executable: $e');
        }
      }
    }

    final thumbPath = p.join(tempDir.path, 'thumb_${DateTime.now().millisecondsSinceEpoch}.jpg');

    final args = [
      '-i',
      videoPath,
      '-ss',
      _formatSeconds(timeSeconds),
      '-vframes',
      '1',
      thumbPath,
    ];

    final result = await Process.run(ffmpegFile.path, args);

    if (result.exitCode != 0) {
      throw Exception('FFmpeg failed on Windows (exit ${result.exitCode}): ${result.stderr}');
    }

    return thumbPath;
  }

  Future<String> _generateThumbnailDesktopUnix(String videoPath, {double timeSeconds = 5.0}) async {
    const ffmpegCmd = 'ffmpeg';
    final tempDir = await getTemporaryDirectory();
    final thumbPath = p.join(tempDir.path, 'thumb_${DateTime.now().millisecondsSinceEpoch}.jpg');

    final result = await Process.run(ffmpegCmd, [
      '-i',
      videoPath,
      '-ss',
      _formatSeconds(timeSeconds),
      '-vframes',
      '1',
      thumbPath,
    ]);

    if (result.exitCode != 0) {
      throw Exception('FFmpeg failed on Unix desktop (exit ${result.exitCode}): ${result.stderr}');
    }
    return thumbPath;
  }

  Future<String> _generateThumbnailMobile(String videoPath, {double timeSeconds = 5.0}) async {
    final tmpDir = await getTemporaryDirectory();
    final output = p.join(tmpDir.path, 'thumb_${DateTime.now().millisecondsSinceEpoch}.jpg');

    final command = '-i "$videoPath" -ss ${timeSeconds.toString()} -vframes 1 "$output"';
    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();

    if (returnCode == null) {
      throw Exception('FFmpegKit returned null return code.');
    }

    if (!ReturnCode.isSuccess(returnCode)) {
      final rcVal = returnCode.getValue();
      throw Exception('FFmpegKit failed (return code $rcVal).');
    }

    return output;
  }

  String _formatSeconds(double seconds) {
    final whole = seconds.floor();
    final h = whole ~/ 3600;
    final m = (whole % 3600) ~/ 60;
    final s = whole % 60;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    } else {
      return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
  }
}
