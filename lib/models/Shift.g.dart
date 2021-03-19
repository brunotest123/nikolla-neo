// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Shift.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShiftStatusAdapter extends TypeAdapter<ShiftStatus> {
  @override
  final int typeId = 8;

  @override
  ShiftStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ShiftStatus.maintenance;
      case 1:
        return ShiftStatus.online;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, ShiftStatus obj) {
    switch (obj) {
      case ShiftStatus.maintenance:
        writer.writeByte(0);
        break;
      case ShiftStatus.online:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShiftStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ShiftAdapter extends TypeAdapter<Shift> {
  @override
  final int typeId = 10;

  @override
  Shift read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Shift(
      id: fields[0] as String,
      name: fields[1] as String,
      kind: fields[5] as String,
      startTime: fields[2] as DateTime,
      endTime: fields[3] as DateTime,
      weekDays: (fields[4] as List)?.cast<String>(),
      status: fields[6] as ShiftStatus,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Shift obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.endTime)
      ..writeByte(4)
      ..write(obj.weekDays)
      ..writeByte(5)
      ..write(obj.kind)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShiftAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
