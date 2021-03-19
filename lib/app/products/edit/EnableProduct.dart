import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Products.dart';
import 'package:nikolla_neo/app/place/edit/components/PlaceForm.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:nikolla_neo/styleguide/screen-container.dart';

class EnableProduct extends StatelessWidget with PlaceForm {
  final Place place;
  final Product product;

  EnableProduct({@required this.product, @required this.place})
      : assert(product != null && place != null) {
    map['id'] = product.id;
    map['status'] = product.status;
  }

  @override
  fetchValue(BuildContext context) async {
    EasyLoading.show();

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

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) => ScreenContainer(
      child: Row(children: <Widget>[
        Expanded(
            child: Text("Online?",
                style: TextStyle(
                  color: darkGrey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0,
                ))),
        Switch(
            value: (product.status == ProductStatus.online),
            onChanged: (value) {
              map['status'] = ((product.status == ProductStatus.online)
                  ? 'maintenance'
                  : 'online');
              fetchValue(context);
            })
      ]),
      right: 15);

  @override
  checkForm() => true;
}
