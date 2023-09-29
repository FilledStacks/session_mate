import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NativeInformationService {
  late PackageInfo packageInfo;
  late DeviceInfoPlugin deviceInfo;

  late AndroidDeviceInfo androidDeviceInfo;
  late IosDeviceInfo iosDeviceInfo;

  Future<void> intialise() async {
    packageInfo = await PackageInfo.fromPlatform();
    deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      androidDeviceInfo = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      iosDeviceInfo = await deviceInfo.iosInfo;
    }
  }

  String get appVersion => packageInfo.buildNumber;

  String get appId => packageInfo.packageName;

  String get osVersion => Platform.isAndroid
      ? androidDeviceInfo.version.release
      : iosDeviceInfo.systemVersion;

  String get platform => Platform.isAndroid ? 'android' : 'ios';

  String get uniqueIdentifier => Platform.isAndroid
      ? androidDeviceInfo.fingerprint
      : iosDeviceInfo.identifierForVendor ?? 'NO_IOS_IDENTIFIER_PASS_USER_ID';
}
