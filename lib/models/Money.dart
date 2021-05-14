import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:hive/hive.dart';

part 'Money.g.dart';

@HiveType(typeId: 9)
class Money {
  @HiveField(0)
  final int cents;
  @HiveField(1)
  final String currencyISO;

  Money({@required this.cents, @required this.currencyISO})
      : assert(cents != null && currencyISO != null);

  toJson(Map<String, dynamic> data, String field) {
    if (cents != null) data[field + '_cents'] = this.cents;
    if (currencyISO != null) data[field + '_currency'] = this.currencyISO;
  }

  double toDouble() {
    return cents / 100.0;
  }

  String toNumberFormat() =>
      NumberFormat.simpleCurrency(name: currencyISO).format(toDouble());

  factory Money.fromJson(Map<String, dynamic> json) => (json == null
      ? null
      : Money(cents: json['cents'], currencyISO: json['currency_iso']));
}
