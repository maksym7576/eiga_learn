import 'package:hive/hive.dart';

@HiveType(typeId: 3)
class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final int typeId = 3;

  @override
  Duration read(BinaryReader reader) {
    final microseconds = reader.readInt();
    return Duration(microseconds: microseconds);
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer.writeInt(obj.inMicroseconds);
  }
}