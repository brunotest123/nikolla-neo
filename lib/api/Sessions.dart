import 'package:flutter/material.dart';
import 'package:nikolla_neo/api/clients/HttpService.dart';
import 'package:nikolla_neo/models/Session.dart';
import 'package:nikolla_neo/models/User.dart';

class Sessions {
  final HttpService _httpService =
      HttpService<Session, SessionSerializable>(SessionSerializable());

  create({@required User user, @required Session session}) async {
    return _httpService.post(
        path: "/v2/users/${user.id}/auths", params: session.toMap());
  }

  update({@required Session session}) async {
    return _httpService.put(path: "/v2/sessions", params: session.toMap());
  }

  buildSalt({@required Session session}) =>
      _httpService.put(path: "/v2/auths", params: session.toMap());
}
