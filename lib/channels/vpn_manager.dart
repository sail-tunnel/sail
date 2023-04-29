import 'package:flutter/services.dart';
import 'package:sail/utils/common_util.dart';
enum VpnStatus {
  connected(code: 2),
  connecting(code: 1),
  reasserting(code: 4),
  disconnecting(code: 5),
  disconnected(code: 0),
  invalid(code: 3);
  const VpnStatus({required this.code});
  final int code;
}
class VpnManager {
  Future<VpnStatus> getStatus() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    int result;
    try {
      result = await platform.invokeMethod("getStatus");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return VpnStatus.values.firstWhere((e) => e.code == result);
  }
  Future<DateTime> getConnectedDate() async {
    // Native channel
    const platform = MethodChannel("com.sail_tunnel.sail/vpn_manager");
    double result;
    try {
      result = await platform.invokeMethod("getConnectedDate");
    } on PlatformException catch (e) {
      print(e.toString());
      rethrow;
    }
    return DateTime.fromMillisecondsSinceEpoch((result * 1000).toInt());
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
