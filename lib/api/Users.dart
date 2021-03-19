import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/clients/HttpService.dart';
import 'package:nikolla_neo/models/User.dart';

class Users {
  final HttpService _httpService =
      HttpService<User, UserSerializable>(UserSerializable());

  update({@required User user}) =>
      _httpService.put(path: '/v2/user', params: user.toMap());

  show() => _httpService.get(path: '/v2/user');
}
