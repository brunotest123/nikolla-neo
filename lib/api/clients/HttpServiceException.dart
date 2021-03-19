import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

Logger _loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class HttpServiceException implements Exception {
  String cause;
  StackTrace stackTrace;
  DioError dioError;

  HttpServiceException({this.cause, this.stackTrace, this.dioError}) {
    // FirebaseCrashlytics.instance.recordError(cause, stackTrace);
    _loggerNoStack.w("HTTPService error: " +
        cause +
        "\n" +
        "response code: " +
        dioError.response.statusCode.toString());
  }
}
