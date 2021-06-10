import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/ProductPhotos.dart';
import 'package:nikolla_neo/api/Products.dart';
import 'package:nikolla_neo/app/BaseController.dart';
import 'package:nikolla_neo/components/commons/CommonDatabase.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/models/ProductPhoto.dart';

class FetchProductsController extends BaseController {
  final Place place;

  FetchProductsController({@required this.place});

  @override
  call() async {
    EasyLoading.show();

    _fetchProducts();

    EasyLoading.dismiss();
  }

  _fetchProducts() async {
    try {
      Place rebase = Place.fromMap(place.toMap());

      List<Product> products =
          await Products().list(domain: Domain.hosts, place: place);

      rebase.products.clear();
      rebase.products.addAll(products);

      await CommonDatabase.update<Place>(table: hostPlacesTable, data: rebase);
    } catch (errorMessage, stacktrace) {
      newExceptionLog(errorMessage, stacktrace);
    }
  }
}
