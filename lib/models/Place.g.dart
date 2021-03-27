// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 4;

  @override
  Place read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Place(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      addressOne: fields[3] as String,
      addressTwo: fields[4] as String,
      postalCode: fields[5] as String,
      city: fields[6] as String,
      county: fields[7] as String,
      country: fields[8] as String,
      locale: fields[11] as String,
      lat: fields[12] as double,
      lng: fields[13] as double,
      timeZone: fields[14] as String,
      products: (fields[9] as List)?.cast<Product>(),
      shifts: (fields[10] as List)?.cast<Shift>(),
      coverImagePath: fields[15] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.addressOne)
      ..writeByte(4)
      ..write(obj.addressTwo)
      ..writeByte(5)
      ..write(obj.postalCode)
      ..writeByte(6)
      ..write(obj.city)
      ..writeByte(7)
      ..write(obj.county)
      ..writeByte(8)
      ..write(obj.country)
      ..writeByte(9)
      ..write(obj.products)
      ..writeByte(10)
      ..write(obj.shifts)
      ..writeByte(11)
      ..write(obj.locale)
      ..writeByte(12)
      ..write(obj.lat)
      ..writeByte(13)
      ..write(obj.lng)
      ..writeByte(14)
      ..write(obj.timeZone)
      ..writeByte(15)
      ..write(obj.coverImagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
