// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final int typeId = 0;

  @override
  Session read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Session(
      id: fields[0] as String,
      buildVersion: fields[1] as String,
      salt: fields[2] as String,
      deviceName: fields[3] as String,
      deviceModel: fields[4] as String,
      systemName: fields[5] as String,
      systemVersion: fields[6] as String,
      refreshToken: fields[7] as String,
      lat: fields[8] as double,
      location: fields[10] as String,
      lng: fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.buildVersion)
      ..writeByte(2)
      ..write(obj.salt)
      ..writeByte(3)
      ..write(obj.deviceName)
      ..writeByte(4)
      ..write(obj.deviceModel)
      ..writeByte(5)
      ..write(obj.systemName)
      ..writeByte(6)
      ..write(obj.systemVersion)
      ..writeByte(7)
      ..write(obj.refreshToken)
      ..writeByte(8)
      ..write(obj.lat)
      ..writeByte(9)
      ..write(obj.lng)
      ..writeByte(10)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
