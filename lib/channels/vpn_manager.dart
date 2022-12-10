import 'package:flutter/services.dart';
import 'package:sail/utils/common_util.dart';

class VpnManager {
  Future<bool> getStatus() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result;
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
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    bool result = false;
    try {
      result = await platform.invokeMethod("toggle");
    } on PlatformException catch (e) {
      print(e.toString());

      rethrow;
    }
    return result;
  }

  Future<String> getTunnelLog() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    String result;
    try {
      result = await platform.invokeMethod("getTunnelLog");
    } on PlatformException catch (e) {
      print(e.toString());

      rethrow;
    }
    return result;
  }

  Future<String> getTunnelConfiguration() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    String result;
    try {
      result = await platform.invokeMethod("getTunnelConfiguration");
    } on PlatformException catch (e) {
      print(e.toString());

      rethrow;
    }
    return result;
  }

  Future<String> setTunnelConfiguration(String conf) async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    String result;
    try {
      result = await platform.invokeMethod("setTunnelConfiguration", conf);
    } on PlatformException catch (e) {
      print(e.toString());

      rethrow;
    }
    return result;
  }
}
