import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/ProductPhotos.dart';

import 'package:nikolla_neo/app/product-photos/shared/ProductPhotoItem.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/components/widgets/UploadPictureWidget.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/models/ProductPhoto.dart';
import 'package:nikolla_neo/styleguide/colors.dart';

import '../controllers/FetchProductPhotosController.dart';

class Index extends StatelessWidget {
  final Place place;
  final Product product;

  Index({@required this.place, @required this.product})
      : assert(place != null, product != null) {
    FetchProductPhotosController(place: place, product: product).call();
  }

  _fetchImage(String publicId) async {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['path_image'] = publicId;
    map['ordering'] = 0;
    map['cover'] = false;

    ProductPhoto _productPhoto = ProductPhotos().save(
        domain: Domain.hosts,
        place: place,
        product: product,
        productPhoto: ProductPhoto.fromMap(map));

    Place placeResult = Place.fromMap(place.toMap());

    Product productResult =
        placeResult.products.firstWhere((element) => element == product);

    int _index = productResult.productPhotos
        .indexWhere((element) => element == _productPhoto);

    if (_index == -1) {
      productResult.productPhotos.add(_productPhoto);
    } else {
      productResult.productPhotos[_index] = _productPhoto;
    }
    
    int _indexProduct = placeResult.products.indexWhere((element) => element == product);
    placeResult.products[_indexProduct] = productResult;

    await CommonDatabase.update<Place>(table: hostPlacesTable, data: placeResult);

  }

  _deleteProductPhoto(ProductPhoto photo){
    ProductPhotos().delete(domain: Domain.hosts, place: place, product: product, productPhoto: photo);
  }

  Widget _addPhoto(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add_a_photo),
      tooltip: 'Add a photo',
      onPressed: () {
        UploadPictureWidget(
            context: context,
            afterSaved: (String publicId) {
              _fetchImage(publicId);
            }).openDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(product.toJson());

    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Product Photos",
              style: TextStyle(color: darkGrey),
            ),
            actions: [_addPhoto(context)],
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
        body: ValueListenableBuilder(
            valueListenable: Hive.box<Place>(hostPlacesTable).listenable(),
            builder: (context, Box<Place> box, child) {
              if (box.values.isEmpty) {
                return Center(child: Text('no product'));
              }

              Place place =
                  box.values.firstWhere((element) => element == this.place);

              Product response =
                  place.products.firstWhere((element) => element == product);

              if (response.productPhotos.isEmpty) {
                return Center(child: Text('No photos'));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: response.productPhotos.length,
                itemBuilder: (context, i) => ProductPhotoItem(
                  productPhoto: response.productPhotos[i],
                  deletePhoto: (){
                    _deleteProductPhoto(response.productPhotos[i]);
                  } 
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              );
            }));
  }
}
