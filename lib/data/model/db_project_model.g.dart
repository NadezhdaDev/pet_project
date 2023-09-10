// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_project_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DBProjectModelAdapter extends TypeAdapter<DBProjectModel> {
  @override
  final int typeId = 1;

  @override
  DBProjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DBProjectModel(
      uuid: fields[0] as String,
      imagePath: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DBProjectModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DBProjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
