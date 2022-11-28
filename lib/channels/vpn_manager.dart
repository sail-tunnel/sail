import 'package:flutter/services.dart';
import 'package:sail_app/utils/common_util.dart';

class VpnManager {
  Future<int> getStatus() async {
    // Native channel
    const platform = MethodChannel("com.losgif.sail/vpn_manager");
    int result;
    try {
      result = await platform.invokeMethod("getStatus");
    } on PlatformException catch (e) {
      print(e.toString());

      rethrow;
    }
    return result;
  }

  Future<bool> toggle() async {
    // Native channel
    const platform = MethodChannel("com.losgif.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("toggle");
    } on PlatformException catch (e) {
      print(e.toString());

      rethrow;
    }
    return result;
  }
}
