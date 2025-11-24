import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_udid/flutter_udid.dart';

class DeviceUtils {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> uuid() async {
    return await FlutterUdid.udid;
  }

  Future<String> name() async {
    String name = 'unknown';
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      name = androidInfo.manufacturer;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      name = iosInfo.utsname.machine;
    }
    return name;
  }

  double convertVersionToDouble(String version) {
    List<String> parts = version.split('.');
    String combined = "${parts[0]}.${parts[1]}";
    return double.parse(combined);
  }

  Future<String> model() async {
    String model = 'unknown';
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      model = androidInfo.model;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      model = iosInfo.model;
    }
    return model;
  }

  Future<String> getOSVersion() async {
    String osVersion = 'unknown';
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      osVersion = androidInfo.version.release;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      osVersion = iosInfo.systemVersion;
    }
    return osVersion;
  }

  static Future<String> getPublicIp() async {
    try {
      final dio = Dio();
      final response = await dio.get('https://api.ipify.org?format=json');
      final String ip = response.data['ip'];
      return ip;
    } catch (e) {
      return "";
    }
  }

  // Static convenience methods
  static Future<String> getDeviceId() async {
    return await FlutterUdid.udid;
  }

  static int getPlatformType() {
    if (Platform.isAndroid) {
      return 1;
    } else if (Platform.isIOS) {
      return 2;
    }
    return 0; // Unknown platform
  }

  static Future<String> getPlatformVersion() async {
    final DeviceUtils deviceUtils = DeviceUtils();
    return await deviceUtils.getOSVersion();
  }

  static Future<String> getDeviceModel() async {
    final DeviceUtils deviceUtils = DeviceUtils();
    return await deviceUtils.model();
  }

  static Future<String> getDeviceName() async {
    final DeviceUtils deviceUtils = DeviceUtils();
    return await deviceUtils.name();
  }

  String encryptId(String value) =>
      base64Encode(utf8.encode(sha256.convert(utf8.encode(value)).toString()));

  // Future<DeviceInfo> getDeviceInfo(
  //   BuildContext context,
  //   WidgetRef ref,
  //   Position? position,
  // ) async => DeviceInfo(
  //   // ignore: use_build_context_synchronously
  //   appLanguage: context.locale.languageCode,
  //   deviceIdentifier: await uuid(),
  //   platformType: 1,
  //   platformVersion: await getOSVersion(),
  //   platformInfo: await name(),
  //   pushToken:
  //       await ref.read(firebasePushNotificationProvider).getFirebaseToken() ??
  //       '',
  //   latitude: position?.latitude.toString() ?? '',
  //   longitude: position?.longitude.toString() ?? '',
  // );
}
