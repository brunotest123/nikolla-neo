import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/Products.dart';
import 'package:nikolla_neo/app/place/edit/components/PlaceForm.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/commons/WeekDaysTransale.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

class WeekDaysAvailablity extends StatelessWidget with PlaceForm {
  final Place place;
  final Product product;

  WeekDaysAvailablity({
    @required this.place,
    @required this.product,
  }) : assert(place != null && product != null) {
    formValidNotifier.value = true;
    map['id'] = product.id;
    map['exclusive_week_days'] = product.exclusiveWeekDays.toList();
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
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: placeAppBar(title: "Week days available", context: context),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Place>(hostPlacesTable).listenable(),
          builder: (context, Box<Place> box, child) {
            Place placeData =
                box.values.firstWhere((element) => element.id == place.id);

            return CheckboxGroup(
              checkColor: darkGrey,
              activeColor: lightGrey,
              labels: WeekDaysTranslate.list(),
              checked: placeData.products
                  .firstWhere((element) => element == product)
                  .exclusiveWeekDays,
              labelStyle: TextStyle(
                  color: darkGrey,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0),
              onSelected: (List selected) {
                map['exclusive_week_days'] = selected;
                fetchValue(context);
              },
            );
          }));

  @override
  checkForm() {
    throw UnimplementedError();
  }
}
