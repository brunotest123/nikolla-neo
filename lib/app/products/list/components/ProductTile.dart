import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/clients/CloudinaryShared.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/styleguide/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            leading: _avatar(),
            title: Text(product.name)),
        Divider()
      ]);

  Widget _avatar() {
    if (product.productPhotos.length == 0){
      return CircleAvatar(
          child: Icon(Icons.camera_alt_outlined, color: lightGrey),
          backgroundColor: darkGreyFive);
    } else {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
          height: 40.0,
          width: 40.0,
          child: CachedNetworkImage(
              imageUrl: CloudinaryShared.imageThumbAvatar(
                  publicId: product.productPhotos.firstWhere((photo) => photo.ordering == 1).pathImage),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()))),
    );

    }

  }
}
