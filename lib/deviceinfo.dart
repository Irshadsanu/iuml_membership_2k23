import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class DeviceInfo{
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> fun_initPlatformState() async {
    try {
      if (Platform.isAndroid) {
        return _readAndroidBuildData(await deviceInfoPlugin.androidInfo);

      } else if (Platform.isIOS) {
        return _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      return 'No ID';
    }
    return 'No ID';

  }

  _readAndroidBuildData(AndroidDeviceInfo build) {
    return build.androidId!;

  }

  _readIosDeviceInfo(IosDeviceInfo data) {
    return data.utsname.version!;

  }
}