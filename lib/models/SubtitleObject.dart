

import 'package:hive/hive.dart';

part 'SubtitleObject.g.dart';

@HiveType(typeId: 2)
class SubtitleObject extends HiveObject {
  @HiveField(0)
  int index;

  @HiveField(1)
  Duration? startTime;

  @HiveField(2)
  Duration? endTime;

  @HiveField(3)
  String? wordsJP;

  @HiveField(4)
  String? translation;

  @HiveField(5)
  String videoId;

  @HiveField(6)
  bool isActive;

  SubtitleObject({
    required this.index,
    this.startTime,
    this.endTime,
    this.wordsJP,
    this.translation,
    required this.videoId,
    this.isActive = false,
  });

  SubtitleObject copyWith({
    int? index,
    Duration? startTime,
    Duration? endTime,
    String? wordsJP,
    String? translation,
    String? videoId,
    bool? isActive,
  }) {
    return SubtitleObject(
      index: index ?? this.index,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      wordsJP: wordsJP ?? this.wordsJP,
      translation: translation ?? this.translation,
      videoId: videoId ?? this.videoId,
      isActive: isActive ?? this.isActive,
    );
  }
}