import 'package:flutter/cupertino.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/clients/HttpService.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';

class Shifts {
  final HttpService _httpService =
      HttpService<Shift, ShiftSerializable>(ShiftSerializable());

  list({@required Domain domain, @required Place place}) =>
      _httpService.get(domain: domain, path: "/places/${place.id}/shifts");

  save({@required Domain domain, @required Place place, Shift shift}) =>
      (shift.id == null
          ? create(domain: domain, place: place, shift: shift)
          : update(domain: domain, place: place, shift: shift));

  create({@required Domain domain, @required Place place, Shift shift}) =>
      _httpService.post(
          domain: domain,
          path: "/places/${place.id}/shifts",
          params: shift.toMap(ignoreId: true));

  update(
          {@required Domain domain,
          @required Place place,
          @required Shift shift}) =>
      _httpService.put(
          domain: domain,
          path: "/places/${place.id}/shifts/${shift.id}",
          params: shift.toMap(ignoreId: true));
}
