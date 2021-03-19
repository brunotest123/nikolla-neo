// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GuestProfile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GuestProfileAdapter extends TypeAdapter<GuestProfile> {
  @override
  final int typeId = 2;

  @override
  GuestProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GuestProfile(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GuestProfile obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuestProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
