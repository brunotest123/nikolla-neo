// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Booking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookingAdapter extends TypeAdapter<Booking> {
  @override
  final int typeId = 11;

  @override
  Booking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Booking(
      id: fields[0] as String,
      startAt: fields[1] as DateTime,
      endAt: fields[2] as DateTime,
      kind: fields[3] as String,
      numGuest: fields[4] as int,
      status: fields[5] as String,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
      user: fields[8] as User,
      place: fields[9] as Place,
      shift: fields[10] as Shift,
    );
  }

  @override
  void write(BinaryWriter writer, Booking obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startAt)
      ..writeByte(2)
      ..write(obj.endAt)
      ..writeByte(3)
      ..write(obj.kind)
      ..writeByte(4)
      ..write(obj.numGuest)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.user)
      ..writeByte(9)
      ..write(obj.place)
      ..writeByte(10)
      ..write(obj.shift);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
