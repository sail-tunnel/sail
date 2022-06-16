import 'package:flutter/services.dart';
import 'package:sail_app/utils/common_util.dart';

class VpnManager {
  Future<bool> enableVPNManager() async {
    // Native channel
    const platform = MethodChannel("com.losgif.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("enableVPNManager");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
