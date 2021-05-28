import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/clients/HttpService.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Product.dart';
import 'package:nikolla_neo/models/ProductPhoto.dart';

class ProductPhotos {
  final HttpService _httpService =
      HttpService<ProductPhoto, ProductPhotoSerializable>(
          ProductPhotoSerializable());

  list(
          {@required Domain domain,
          @required Place place,
          @required Product product}) =>
      _httpService.get(
          domain: domain,
          path: '/places/${place.id}/products/${product.id}/photos/');

  save(
          {@required Domain domain,
          @required Place place,
          @required Product product,
          @required ProductPhoto productPhoto}) =>
      (productPhoto.id == null
          ? create(domain: domain, place: place, product: product, productPhoto: productPhoto)
          : update(domain: domain, place: place, product: product, productPhoto: productPhoto));

  create(
          {@required Domain domain,
          @required Place place,
          @required Product product,
          @required ProductPhoto productPhoto}) =>
      _httpService.post(
          domain: domain,
          path: '/places/${place.id}/products/${product.id}/photos/',
          params: productPhoto.toMap());

  update(
          {@required Domain domain,
          @required Place place,
          @required Product product,
          @required ProductPhoto productPhoto}) =>
      _httpService.put(
          domain: domain,
          path:
              '/places/${place.id}/products/${product.id}/photos/${productPhoto.id}',
          params: productPhoto.toMap(ignoreId: true));
  
    delete(
          {@required Domain domain,
          @required Place place,
          @required Product product,
          @required ProductPhoto productPhoto}) =>
      _httpService.delete(
          domain: domain,
          path: '/places/${place.id}/products/${product.id}/photos/${productPhoto.id}');
}
