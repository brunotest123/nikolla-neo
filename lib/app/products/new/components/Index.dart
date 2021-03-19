import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/products/shared/ProductForm.dart';
import 'package:nikolla_neo/models/Place.dart';

class Index extends StatelessWidget {
  final Place place;

  Index({@required this.place}) : assert(place != null);

  @override
  Widget build(BuildContext context) => ProductForm(place: place);
}
