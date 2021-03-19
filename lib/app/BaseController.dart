import 'dart:developer' as developer;

import 'package:flutter_easyloading/flutter_easyloading.dart';

abstract class BaseController {
  call();

  newExceptionLog(dynamic errorMessage, StackTrace stacktrace,
      {String friendlyMessage, int durationSeconds}) {
    developer.log(stacktrace.toString());
    developer.log(errorMessage.toString());

    int _seconds = 2;

    if (friendlyMessage == null) return;

    if (durationSeconds != null) _seconds = durationSeconds;

    EasyLoading.showError(friendlyMessage,
        duration: Duration(seconds: _seconds));
  }
}
