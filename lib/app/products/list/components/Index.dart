import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/app/products/list/controllers/FetchProductsController.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

import 'ProductTile.dart';
import '../../new/components/Index.dart' as productNew;

import 'package:nikolla_neo/styleguide/screen-container.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Index extends StatelessWidget {
  final Place place;

  Index({@required this.place}) : assert(place != null) {
    FetchProductsController(place: this.place).call();
  }

  Widget _newProduct() => ValueListenableBuilder(
      valueListenable: Hive.box<Place>(hostPlacesTable).listenable(),
      builder: (context, Box<Place> box, child) {
        if (box.values.isEmpty) {
          return Center(child: Text('no place'));
        }

        Place response = box.values.firstWhere((element) => element == place);

        return Padding(
            padding: EdgeInsets.only(right: 15),
            child: InkWell(
              child: Icon(Icons.plus_one, color: links),
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return productNew.Index(place: response);
                    });
              },
            ));
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Products", style: TextStyle(color: darkGrey)),
            actions: [_newProduct()],
            leading: Container(
              padding: EdgeInsets.only(left: 25),
              child: MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                minWidth: 40.0,
                padding: EdgeInsets.all(0),
                child: Icon(Icons.clear,
                    color: Color.fromRGBO(165, 165, 165, 1.0)),
                onPressed: () {
                  Navigator.pop(context);
                  return;
                },
              ),
            )),
        body: ScreenContainer(
            left: 15,
            right: 0,
            child: ValueListenableBuilder(
                valueListenable: Hive.box<Place>(hostPlacesTable).listenable(),
                builder: (context, Box<Place> box, child) {
                  if (box.values.isEmpty) {
                    return Center(child: Text('no place'));
                  }

                  Place response =
                      box.values.firstWhere((element) => element == place);

                  return ListView(
                      children: response.products
                          .map((product) =>
                              ProductTile(place: response, product: product))
                          .toList());
                })));
  }
}
