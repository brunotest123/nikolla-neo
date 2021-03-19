import 'package:flutter/cupertino.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/clients/HttpService.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';

class Products {
  final HttpService _httpService =
      HttpService<Product, ProductSerializable>(ProductSerializable());

  list({@required Domain domain, @required Place place}) =>
      _httpService.get(domain: domain, path: "/places/${place.id}/products");

  save({@required Domain domain, @required Place place, Product product}) =>
      (product.id == null
          ? create(domain: domain, place: place, product: product)
          : update(domain: domain, place: place, product: product));

  create({@required Domain domain, @required Place place, Product product}) =>
      _httpService.post(
          domain: domain,
          path: "/places/${place.id}/products",
          params: product.toMap());

  update({@required Domain domain, @required Place place, Product product}) =>
      _httpService.put(
          domain: domain,
          path: "/places/${place.id}/products/${product.id}",
          params: product.toMap(ignoreId: true));
}
