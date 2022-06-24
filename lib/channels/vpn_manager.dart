import 'package:flutter/services.dart';
import 'package:sail_app/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:flutter_vpn/state.dart';

class VpnManager {
  Future<bool> enableVPNManager() async {
    // Native channel
    const platform = MethodChannel("com.losgif.sail/vpn_manager");
    bool result = false;
    try {
      return result = await platform.invokeMethod("enableVPNManager");
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return result;
  }
}
