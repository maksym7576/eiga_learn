import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'VideoObject.g.dart';

@HiveType(typeId: 0)
class VideoObject extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? videoPath;

  @HiveField(3)
  String? srtPath;

  @HiveField(4)
  DateTime? createdAt;

  @HiveField(5)
  String? thumbnailPath;

  VideoObject({
    String? id,
    required this.title,
    required this.videoPath,
    required this.srtPath,
    required this.createdAt,
    required this.thumbnailPath,
  }) : id = id ?? const Uuid().v4();

  VideoObject copyWith({
    String? id,
    String? title,
    String? videoPath,
    String? srtPath,
    DateTime? createdAt,
    String? thumbnailPath,
  }) {
    return VideoObject(
      id: id ?? this.id,
      title: title ?? this.title,
      videoPath: videoPath ?? this.videoPath,
      srtPath: srtPath ?? this.srtPath,
      createdAt: createdAt ?? this.createdAt,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
    );
  }
}