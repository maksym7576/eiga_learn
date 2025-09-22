// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubtitleObject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubtitleObjectAdapter extends TypeAdapter<SubtitleObject> {
  @override
  final int typeId = 2;

  @override
  SubtitleObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubtitleObject(
      index: fields[0] as int,
      startTime: fields[1] as Duration?,
      endTime: fields[2] as Duration?,
      wordsJP: fields[3] as String?,
      translation: fields[4] as String?,
      videoId: fields[5] as String,
      isActive: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SubtitleObject obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.wordsJP)
      ..writeByte(4)
      ..write(obj.translation)
      ..writeByte(5)
      ..write(obj.videoId)
      ..writeByte(6)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtitleObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
