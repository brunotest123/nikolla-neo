import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nikolla_neo/api/Domain.dart';
import 'package:nikolla_neo/api/clients/ApiProvider.dart';
import 'package:nikolla_neo/api/clients/HttpServiceException.dart';
import 'package:nikolla_neo/api/clients/Serealizable.dart';
import 'package:enum_to_string/enum_to_string.dart';

class HttpService<T, S extends Serializable<T>> {
  final S _serializable;

  HttpService(this._serializable);

  post(
      {Domain domain,
      @required String path,
      Map<String, dynamic> params}) async {
    try {
      final response = await ApiProvider.post(
          path: _buildPath(domain: domain, path: path),
          params: buildRequestParams(params));

      return _processResponse(response);
    } on DioError catch (e, stackTrace) {
      throw new HttpServiceException(
          cause: e.response.data.toString(),
          dioError: e,
          stackTrace: stackTrace);
    }
  }

  put(
      {Domain domain,
      @required String path,
      Map<String, dynamic> params}) async {
    try {
      final response = await ApiProvider.put(
          path: _buildPath(domain: domain, path: path),
          params: buildRequestParams(params));

      return _processResponse(response);
    } on DioError catch (e, stackTrace) {
      throw new HttpServiceException(
          cause: e.response.data.toString(),
          dioError: e,
          stackTrace: stackTrace);
    }
  }

  get(
      {Domain domain,
      @required String path,
      Map<String, dynamic> params}) async {
    try {
      final response = await ApiProvider.get(
          path: _buildPath(domain: domain, path: path), params: params);

      return _processResponse(response);
    } on DioError catch (e, stackTrace) {
      throw new HttpServiceException(
          cause: e.response.data.toString(),
          dioError: e,
          stackTrace: stackTrace);
    }
  }

  Map<String, dynamic> buildRequestParams(Map<String, dynamic> params) {
    if (params == null) return {};
    if (params[_serializable.record] != null) return params;
    return {_serializable.record: params};
  }

  _processResponse(Response<Map> response) {
    String res2Json = json.encode(response.data);
    dynamic result = json.decode(res2Json);

    if (result['records'] != null)
      return _serializable.fromJsonArray(result['records']);

    if (result['record'] != null)
      return _serializable.fromJson(result['record']);

    return result;
  }

  String _buildPath({Domain domain, String path}) => (domain == null
      ? path
      : "/v2/${EnumToString.convertToString(domain)}$path");
}
