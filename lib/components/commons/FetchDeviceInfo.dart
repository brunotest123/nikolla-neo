import 'dart:io';
import 'package:device_info/device_info.dart';

class FetchDeviceInfo {
  static Future<Map<String, dynamic>> call() async {
    Map<String, dynamic> map = Map<String, dynamic>();

    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (Platform.isIOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;

        map = {
          "device_name": iosDeviceInfo.name,
          "device_model": iosDeviceInfo.model,
          "system_name": iosDeviceInfo.systemName,
          "system_version": iosDeviceInfo.systemVersion
        };
      } else {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;

        map = {
          "device_name": androidDeviceInfo.product,
          "device_model": androidDeviceInfo.model,
          "system_name": "Android " + androidDeviceInfo.version.codename,
          "system_version": androidDeviceInfo.version.baseOS
        };
      }
    } catch (e) {}

    return map;
  }
}
