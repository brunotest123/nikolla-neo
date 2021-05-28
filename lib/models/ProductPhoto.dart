import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/clients/Serealizable.dart';

part 'ProductPhoto.g.dart';

@HiveType(typeId: 13)
class ProductPhoto extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String pathImage;
  @HiveField(2)
  final int ordering;
  @HiveField(3)
  final bool cover;
  @HiveField(4)
  final DateTime createdAt;
  @HiveField(5)
  final DateTime updatedAt;

  ProductPhoto({
    this.id,
    this.pathImage,
    this.ordering,
    this.cover,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap({bool ignoreId}) {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (this.id != null && ignoreId != true) map['id'] = this.id;
    if (this.pathImage != null) map['path_image'] = this.pathImage;
    if (this.ordering != null) map['ordering'] = this.ordering;
    if (this.cover != null) map['cover'] = this.cover;
    if (this.createdAt != null) map['created_at'] = this.createdAt.toString();
    if (this.updatedAt != null) map['updated_at'] = this.updatedAt.toString();

    return map;
  }

  factory ProductPhoto.fromMap(Map<String, dynamic> map) {
    
    return ProductPhoto(
        id: map['id'],
        pathImage: map['path_image'],
        ordering: map['ordering'],
        cover: map['cover'],
        createdAt: (map['created_at'] == null
            ? null
            : DateTime.parse(map['created_at'])),
        updatedAt: (map['updated_at'] == null
            ? null
            : DateTime.parse(map['updated_at'])));
  }

  String toJson() => json.encode(toMap());

  factory ProductPhoto.fromJson(String source) =>
      ProductPhoto.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}

class ProductPhotoSerializable implements Serializable<ProductPhoto> {
  @override
  String record = 'product_photo';

  @override
  String records = 'product_photos';

  @override
  ProductPhoto fromJson(Map<String, dynamic> json,
          {Map<String, dynamic> includedJson}) =>
      ProductPhoto.fromMap(json);

  @override
  Map<String, dynamic> toJson(ProductPhoto entity) => entity.toMap();

  @override
  List<ProductPhoto> fromJsonArray(List<dynamic> jsonArray) =>
      (jsonArray == null
          ? []
          : jsonArray
              ?.map((postMap) => postMap == null ? null : fromJson(postMap))
              ?.toList());

  @override
  List<dynamic> toJsonArray(List<ProductPhoto> postList) =>
      postList?.map((post) => post?.toJson())?.toList();
}
