import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/products/shared/ProductForm.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';

class EditForm extends StatelessWidget {
  final Place place;
  final Product product;

  EditForm({@required this.place, @required this.product})
      : assert(place != null && product != null);

  @override
  Widget build(BuildContext context) =>
      ProductForm(place: place, product: product);
}
