


import 'package:eiga_learn/models/VideoObject.dart';
import 'package:eiga_learn/providers/DatabaseProviders.dart';
import 'package:eiga_learn/services/ThumbnailService.dart';
import 'package:eiga_learn/services/VideoService.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

final videoServiceProvider = StateNotifierProvider<VideoService, List<VideoObject>>((ref) {
  final box = ref.watch(videoBoxProvider);
  return VideoService(box, ref);
});

final thumbnailServiceProvider = Provider<ThumbnailService>((ref) {
  return ThumbnailService();
});