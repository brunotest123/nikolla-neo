import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/clients/HttpService.dart';
import 'package:nikolla_neo/models/GuestProfile.dart';

class GuestProfiles {
  final HttpService _httpService =
      HttpService<GuestProfile, GuestProfileSerializable>(
          GuestProfileSerializable());

  Future<GuestProfile> show() async =>
      await _httpService.get(path: '/v2/guest_profile');

  create({@required GuestProfile guestProfile}) => _httpService.post(
      path: '/v2/guest_profile', params: guestProfile.toMap());

  update({@required GuestProfile guestProfile}) => _httpService.put(
      path: '/v2/guest_profile', params: guestProfile.toMap(ignoreId: true));
}
