import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/clients/HttpService.dart';
import 'package:nikolla_neo/models/Booking.dart';

class Bookings {
  final HttpService _httpService =
      HttpService<Booking, BookingSerializable>(BookingSerializable());

  list({Domain domain}) => _httpService.get(
      domain: Domain.guests,
      path:
          "/places/304f2bd7-4e7c-4a57-b771-338b29e3b8a0/shifts/fcabc2d9-efda-4c50-af12-2244337b631b/bookings");
}
