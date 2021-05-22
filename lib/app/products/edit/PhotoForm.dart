import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/place/edit/components/PlaceForm.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';

class PhotoForm extends StatelessWidget with PlaceForm {
  final Place place;
  final Product product;

  PhotoForm({@required this.place, @required this.product})
      : assert(place != null && product != null);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: placeAppBar(title: 'Edit photos', context: context),
        body: Text('Edit photos!!'),
      );

  @override
  checkForm() {
    throw UnimplementedError();
  }
  // Widget build(BuildContext context) =>
  //     ScreenContainer(child: GridView.builder(
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  //       itemBuilder: (context, i) => Text('')
  //     ));
}
