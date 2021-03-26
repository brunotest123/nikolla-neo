import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/clients/HttpService.dart';
import 'package:nikolla_neo/models/Booking.dart';
import 'package:nikolla_neo/models/Place.dart';
import 'package:nikolla_neo/models/Shift.dart';

class Bookings {
  final HttpService _httpService =
      HttpService<Booking, BookingSerializable>(BookingSerializable());

  _urlPath({Place place, Shift shift, Booking booking}) =>
      "${place == null ? "" : "/places/" + place.id}${shift == null ? "" : "/shifts/" + shift.id}/bookings${booking == null ? "" : "/" + booking.id}";

  create({Domain domain, Place place, Shift shift, Booking booking}) =>
      _httpService.post(
          domain: domain,
          path: _urlPath(place: place, shift: shift),
          params: booking.toMap(ignoreId: true));

  list({Domain domain}) =>
      _httpService.get(domain: Domain.guests, path: _urlPath());
}
