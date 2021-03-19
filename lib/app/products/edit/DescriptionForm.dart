import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Products.dart';
import 'package:nikolla_neo/app/place/edit/components/PlaceForm.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/Validators.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class DescriptionForm extends StatelessWidget with PlaceForm {
  final Place place;
  final Product product;

  DescriptionForm({@required this.place, @required this.product})
      : assert(place != null && product != null) {
    map['id'] = product.id;
    map['description'] = product.description;

    checkForm();
  }

  checkForm() {
    formValidNotifier.value = (Validators.validateText(
            'Description', map['description'],
            required: false, maxText: 1000) ==
        null);
  }

  @override
  fetchValue(BuildContext context) async {
    Product _product = await Products().save(
        domain: Domain.hosts, place: place, product: Product.fromMap(map));

    Place result = Place.fromMap(place.toMap());

    int _index = result.products.indexWhere((element) => element == _product);

    if (_index == -1) {
      result.products.add(_product);
    } else {
      result.products[_index] = _product;
    }

    await CommonDatabase.update<Place>(table: hostPlacesTable, data: result);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      floatingActionButton: floatingActionButton(context),
      appBar: placeAppBar(title: "Description", context: context),
      body: Column(children: [
        ScreenContainer(
            top: 40,
            child: TextFormField(
              initialValue: (this.product.description == null
                  ? ""
                  : this.product.description),
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                icon: Icon(Icons.read_more_sharp),
                hintText: 'Tell me something related to your business',
                labelText: 'Description',
              ),
              maxLength: 1000,
              maxLines: 7,
              autovalidateMode: AutovalidateMode.always,
              onChanged: (String value) {
                map['description'] = value;
                checkForm();
              },
              validator: (String value) {
                return Validators.validateText('Description', value,
                    required: false, maxText: 1000);
              },
            )),
      ]));
}
