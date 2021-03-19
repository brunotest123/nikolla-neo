import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

import '../../edit/Index.dart' as productEdit;

class ProductTile extends StatelessWidget {
  final Place place;
  final Product product;

  ProductTile({@required this.place, @required this.product})
      : assert(place != null && product != null);

  @override
  Widget build(BuildContext context) => Column(children: [
        ListTile(
            onTap: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext xContext) {
                    return productEdit.Index(place: place, product: product);
                  });
            },
            leading: CircleAvatar(
                child: Icon(Icons.camera_alt_outlined, color: lightGrey),
                backgroundColor: darkGreyFive),
            title: Text(product.name)),
        Divider()
      ]);
}
