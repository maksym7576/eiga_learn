




import 'dart:io';

import 'package:eiga_learn/models/VideoObject.dart';
import 'package:eiga_learn/providers/ServicesProviders.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart';

class VideoService extends StateNotifier<List<VideoObject>> {
  final Box<VideoObject> _box;
  final Ref _ref;

  VideoService(this._box, this._ref) : super([]) {
    _init();
  }

  void _init() async{
    state = _box.values.toList();
  }


  Future<String> createVideoObject(String title, String videoPath, String srtPath) async {
    final thumbnail = await _ref.read(thumbnailServiceProvider).generateThumbnail(videoPath);
    final video = VideoObject(
      title: title,
      videoPath: videoPath,
      srtPath: srtPath,
      createdAt: DateTime.now(),
      thumbnailPath: thumbnail,
    );
    await _box.add(video);
    state = _box.values.toList();
    return video.id;
  }

  Future<void> updateVideoName(int index, String newName) async {
    final video = _box.getAt(index);
    if(video != null) {
      final updated = video.copyWith(title: newName);
      await _box.putAt(index, updated);
      state = _box.values.toList();
    }
  }

  Future<void> updateVideoPath(int index, String videoPath) async {
    final video = _box.getAt(index);
    if (video != null) {
      final updated = video.copyWith(videoPath: videoPath);
      await _box.putAt(index, updated);
      state = _box.values.toList();
    }
  }

  Future<void> deleteVideo(int index) async {
    await _box.deleteAt(index);
    state = _box.values.toList();
  }
}