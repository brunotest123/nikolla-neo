import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:nikolla_neo/models/Session.dart';
import 'ServerConfig.dart';

import 'dart:developer' as developer;

final Logger _loggerNoStack = Logger(printer: PrettyPrinter(methodCount: 0));

class ApiProvider {
  static Future<Response<Map>> post(
      {String path, Map<String, dynamic> params}) async {
    Dio instance = await _getInstance();

    _requestData('POST', path, params);

    return _responseData(await instance.post(path, data: params));
  }

  static Future<Response<Map>> put(
      {String path, Map<String, dynamic> params}) async {
    Dio instance = await _getInstance();

    _requestData('PUT', path, params);

    return _responseData(await instance.put(path, data: params));
  }

  static Future<Response<Map>> get(
      {String path, Map<String, dynamic> params}) async {
    Dio instance = await _getInstance();

    _requestData('GET', path, params);

    return _responseData(await instance.get(path, queryParameters: params));
  }

  static void _requestData(
      String method, String path, Map<String, dynamic> params) {
    developer.log("METHOD: GET");
    developer.log("PATH: $path");
    developer.log('Request BODY:');
    _loggerNoStack.v(params);
  }

  static Response<Map> _responseData(Response<Map> response) {
    developer.log('Response BODY:');
    String res2Json = json.encode(response.data);
    dynamic result = json.decode(res2Json);
    _loggerNoStack.v(result);

    return response;
  }

  static Future<Dio> _getInstance() async {
    Box<Session> sessionsBox = Hive.box<Session>(sessionsTable);
    Session currentSession =
        (sessionsBox.values.length > 0 ? sessionsBox.values.first : null);

    BaseOptions options = new BaseOptions(
        baseUrl: ServerConfig.hostName,
        connectTimeout: 30000,
        receiveTimeout: 5000);

    Dio dio = new Dio(options);

    dio.interceptors.add(InterceptorsWrapper(onRequest: (Options options) {
      options.headers['app-secret-token-key'] = ServerConfig.appSecret;

      if (currentSession == null) return;

      if (currentSession.id != null)
        options.headers["session-token-key"] = currentSession.id;

      if (currentSession.refreshToken != null)
        options.headers['session-refresh-key'] = currentSession.refreshToken;
    }));

    if (currentSession != null) {
      developer.log('host: ${ServerConfig.hostName}');
      developer.log("session-refresh-key: ${currentSession.refreshToken}");
      developer.log("session-salt-key: ${currentSession.salt}");
    }

    return dio;
  }
}
