

import 'package:eiga_learn/models/VideoObject.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final videoBoxProvider = Provider<Box<VideoObject>>((ref) {
  return Hive.box<VideoObject>('videoBox');
});