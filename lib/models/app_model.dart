import 'package:sail_app/channels/vpn_manager.dart';
import 'package:sail_app/models/base_model.dart';

class AppModel extends BaseModel {
  VpnManager vpnManager = VpnManager();
  bool isOn = false;

  void togglePowerButton () async {
    if (isOn) {
      await vpnManager.disableVPNManager();
    } else {
      await vpnManager.enableVPNManager();
    }

    isOn = !isOn;

    notifyListeners();
  }
}
