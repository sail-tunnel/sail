import 'package:flutter/services.dart';

class VpnManager {
  Future<bool> enableVPNManager() async {
    // Native channel
    const platform = const MethodChannel("com.losgif.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("enableVPNManager");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
