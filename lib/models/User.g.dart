// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PolicyAdapter extends TypeAdapter<Policy> {
  @override
  final int typeId = 3;

  @override
  Policy read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Policy.nikers;
      case 1:
        return Policy.testUser;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, Policy obj) {
    switch (obj) {
      case Policy.nikers:
        writer.writeByte(0);
        break;
      case Policy.testUser:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PolicyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String,
      countryId: fields[1] as String,
      mobilePhone: fields[2] as String,
      internationalNumber: fields[3] as String,
      policies: (fields[4] as List)?.cast<Policy>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.countryId)
      ..writeByte(2)
      ..write(obj.mobilePhone)
      ..writeByte(3)
      ..write(obj.internationalNumber)
      ..writeByte(4)
      ..write(obj.policies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
