import 'dart:io';
import 'package:ios_utsname_ext/extension.dart';
import 'package:device_info_plus/device_info_plus.dart';

class GetDeviceInfo {
  // (sdk ${androidInfo.version.sdkInt})
  Future getDeviceInfo() async {
    final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidInfo = await _deviceInfoPlugin.androidInfo;
      var deviceInfo = {
        "uuid": "${androidInfo.androidId}",
        "os": "Android",
        "osVer" :  "${androidInfo.version.release}",
        "model" : "${androidInfo.manufacturer} ${androidInfo.model}",
      };

      return deviceInfo;

    } else if (Platform.isIOS) {
      var iosInfo = await _deviceInfoPlugin.iosInfo;
      var deviceInfo = {
        "uuid": "${iosInfo.identifierForVendor}",
        "os": "iOS",
        "osVer" :  "${iosInfo.systemVersion}",
        "model" : "${iosInfo.utsname.machine?.iOSProductName}",
      };
      return deviceInfo;
    }
  }
}


// https://eunjin3786.tistory.com/333
// www.theiphonewiki.com/wiki/Models
