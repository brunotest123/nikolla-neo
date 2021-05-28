import 'package:flutter/material.dart';
import 'package:nikolla_neo/models/ProductPhoto.dart';

class ProductPhotoItem extends StatelessWidget {
  final ProductPhoto productPhoto;
  final Function deletePhoto;

  ProductPhotoItem({@required this.productPhoto, this.deletePhoto})
      : assert(productPhoto != null);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        productPhoto.pathImage,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        subtitle: Text(''),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            deletePhoto();
          },
        ),
      ),
    );
  }
}
