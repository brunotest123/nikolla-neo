import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/ProductPhotos.dart';
import 'package:nikolla_neo/app/BaseController.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/models/ProductPhoto.dart';

class FetchProductPhotosController extends BaseController {
  final Place place;
  final Product product;

  FetchProductPhotosController({@required this.place, @required this.product});

  @override
  call() {
    EasyLoading.show();
    _fetchProductPhotos();
    EasyLoading.dismiss();
  }

  _fetchProductPhotos() async {

    try {

      Place rebase = Place.fromMap(place.toMap());
      Product rebaseProduct = Product.fromMap(product.toMap());

      List<ProductPhoto> productPhotos = await ProductPhotos()
          .list(domain: Domain.hosts, place: place, product: product);

      rebaseProduct.productPhotos.clear();
      rebaseProduct.productPhotos.addAll(productPhotos);

      int _index = rebase.products.indexWhere((element) => element == product);

      rebase.products[_index] = rebaseProduct;

      await CommonDatabase.update<Place>(table: hostPlacesTable, data: rebase);

    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace);
    }
  }

}
