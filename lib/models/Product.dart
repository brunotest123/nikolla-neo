import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:nikolla_neo/api/clients/Serealizable.dart';
import 'package:nikolla_neo/components/commons/WeekDaysTransale.dart';
import 'package:nikolla_neo/models/Money.dart';

part 'Product.g.dart';

@HiveType(typeId: 7)
enum ProductStatus {
  @HiveField(0)
  maintenance,
  @HiveField(1)
  online
}

const productStatusString = <ProductStatus, String>{
  ProductStatus.maintenance: "maintenance",
  ProductStatus.online: 'online'
};

@HiveType(typeId: 6)
class Product extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final int ordering;
  @HiveField(4)
  final Money sale;
  @HiveField(5)
  final DateTime createdAt;
  @HiveField(6)
  final DateTime updatedAt;
  @HiveField(7)
  final String description;
  @HiveField(8)
  final ProductStatus status;
  @HiveField(9)
  final List<String> exclusiveWeekDays;

  Product(
      {this.id,
      this.name,
      this.category,
      this.ordering,
      this.sale,
      this.createdAt,
      this.updatedAt,
      this.description,
      this.status,
      this.exclusiveWeekDays});

  String weekDaysAvailable(BuildContext context) =>
      (this.exclusiveWeekDays.length == 0 || this.exclusiveWeekDays.length == 7
          ? "All week days available"
          : WeekDaysTranslate.translated(context,
                  weekDaysList: this.exclusiveWeekDays)
              .join(', '));

  Map<String, dynamic> toMap({bool ignoreId}) {
    Map<String, dynamic> map = Map<String, dynamic>();

    if (this.id != null && ignoreId != true) map['id'] = this.id;
    if (this.name != null) map['name'] = this.name;
    if (this.description != null) map['description'] = this.description;
    if (this.category != null) map['category_name'] = this.category;
    if (this.ordering != null) map['ordering'] = this.ordering;
    if (this.sale != null) map['sale'] = this.sale.toJson();
    if (this.createdAt != null) map['created_at'] = this.createdAt.toString();
    if (this.updatedAt != null) map['updated_at'] = this.updatedAt.toString();
    if (this.status != null) map['status'] = productStatusString[this.status];
    if (this.exclusiveWeekDays != null)
      map['exclusive_week_days'] = this.exclusiveWeekDays.toList();

    return map;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    List<dynamic> exclusiveWeekDaysParsed =
        (map['exclusive_week_days'] == null ? [] : map['exclusive_week_days']);

    return Product(
        id: map['id'],
        name: map['name'],
        category: map['category_name'],
        description: map['description'],
        ordering: map['ordering'],
        status: EnumToString.fromString(ProductStatus.values, map['status']),
        exclusiveWeekDays:
            exclusiveWeekDaysParsed.map((i) => i.toString()).toList(),
        createdAt: (map['created_at'] == null
            ? null
            : DateTime.parse(map['created_at'])),
        updatedAt: (map['updated_at'] == null
            ? null
            : DateTime.parse(map['updated_at'])),
        sale: Money.fromJson(map['sale']));
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}

class ProductSerializable implements Serializable<Product> {
  @override
  String record = 'product';

  @override
  String records = 'products';

  @override
  Product fromJson(Map<String, dynamic> json,
          {Map<String, dynamic> includedJson}) =>
      Product.fromMap(json);

  @override
  Map<String, dynamic> toJson(Product entity) => entity.toMap();

  @override
  List<Product> fromJsonArray(List<dynamic> jsonArray) => (jsonArray == null
      ? []
      : jsonArray
          ?.map((postMap) => postMap == null ? null : fromJson(postMap))
          ?.toList());

  @override
  List<dynamic> toJsonArray(List<Product> postList) =>
      postList?.map((post) => post?.toJson())?.toList();
}
