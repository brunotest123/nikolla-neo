// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HostProfile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HostProfileAdapter extends TypeAdapter<HostProfile> {
  @override
  final int typeId = 5;

  @override
  HostProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HostProfile(
      id: fields[0] as String,
      name: fields[1] as String,
      planId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HostProfile obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.planId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HostProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
