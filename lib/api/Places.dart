import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/clients/HttpService.dart';
import 'package:nikolla_neo/models/Place.dart';

class Places {
  final HttpService _httpService =
      HttpService<Place, PlaceSerializable>(PlaceSerializable());

  list({@required Domain domain, Map<String, dynamic> params}) =>
      _httpService.get(domain: domain, path: "/places", params: params);

  create({Domain domain, Place place}) =>
      _httpService.post(domain: domain, path: "/places", params: place.toMap());

  update({Domain domain, Place place}) => _httpService.put(
      domain: domain,
      path: "/places/${place.id}",
      params: place.toMap(ignoreId: true));
}
