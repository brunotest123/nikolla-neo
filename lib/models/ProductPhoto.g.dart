// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductPhoto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductPhotoAdapter extends TypeAdapter<ProductPhoto> {
  @override
  final int typeId = 13;

  @override
  ProductPhoto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductPhoto(
      id: fields[0] as String,
      pathImage: fields[1] as String,
      ordering: fields[2] as int,
      cover: fields[3] as bool,
      createdAt: fields[4] as DateTime,
      updatedAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProductPhoto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pathImage)
      ..writeByte(2)
      ..write(obj.ordering)
      ..writeByte(3)
      ..write(obj.cover)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductPhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}