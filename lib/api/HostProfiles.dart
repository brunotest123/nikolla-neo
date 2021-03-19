import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/clients/HttpService.dart';
import 'package:nikolla_neo/models/HostProfile.dart';

class HostProfiles {
  final HttpService _httpService =
      HttpService<HostProfile, HostProfileSerializable>(
          HostProfileSerializable());

  Future<HostProfile> show() async =>
      await _httpService.get(path: '/v2/host_profile');

  create({@required HostProfile hostProfile}) =>
      _httpService.post(path: '/v2/host_profile', params: hostProfile.toMap());

  update({@required HostProfile hostProfile}) => _httpService.put(
      path: '/v2/host_profile', params: hostProfile.toMap(ignoreId: true));
}
