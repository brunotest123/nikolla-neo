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

    return _responseData(await instance.post(path, data: params));
  }

  static Future<Response<Map>> put(
      {String path, Map<String, dynamic> params}) async {
    Dio instance = await _getInstance();

    return _responseData(await instance.put(path, data: params));
  }

  static Future<Response<Map>> get(
      {String path, Map<String, dynamic> params}) async {
    Dio instance = await _getInstance();

    return _responseData(await instance.get(path, queryParameters: params));
  }

  static Future<Response<Map>> delete(
      {String path, Map<String, dynamic> params}) async {
    Dio instance = await _getInstance();
    return _responseData(await instance.delete(path, data: params));
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

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        developer.log('HOST: ${ServerConfig.hostName}');
        developer.log('REQUEST[${options.method}] => PATH: ${options.path}');

        if (options.queryParameters != null || options.queryParameters != {})
          developer
              .log("REQUEST[queryStringParams] => ${options.queryParameters}");

        if (options.data != null)
          developer.log("REQUEST[body] => ${options.data}");

        options.headers['app-secret-token-key'] = ServerConfig.appSecret;

        if (currentSession != null) {
          if (currentSession.id != null)
            options.headers["session-token-key"] = currentSession.id;

          if (currentSession.refreshToken != null)
            options.headers['session-refresh-key'] =
                currentSession.refreshToken;
        }

        developer.log("REQUEST[headers]: ${options.headers}");

        return handler.next(options);
      },
    ));

    return dio;
  }
}
