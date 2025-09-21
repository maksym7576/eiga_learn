// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VideoObject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoObjectAdapter extends TypeAdapter<VideoObject> {
  @override
  final int typeId = 0;

  @override
  VideoObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoObject(
      id: fields[0] as String?,
      title: fields[1] as String?,
      videoPath: fields[2] as String?,
      srtPath: fields[3] as String?,
      createdAt: fields[4] as DateTime?,
      thumbnailPath: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoObject obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.videoPath)
      ..writeByte(3)
      ..write(obj.srtPath)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.thumbnailPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
