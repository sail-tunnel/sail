import 'package:flutter/material.dart';
import 'package:sail_app/channels/vpn_manager.dart';
import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/models/base_model.dart';

class AppModel extends BaseModel {
  VpnManager vpnManager = VpnManager();
  bool isOn = false;
  PageController pageController = PageController(initialPage: 0);
  String appTitle = 'Sail';

  final Map _tabMap = {
    0: AppStrings.appName,
    1: '套餐',
    2: '节点',
    3: '我的',
  };

  void jumpToPage(int page) {
    pageController.jumpToPage(page);
    appTitle = _tabMap[page];

    notifyListeners();
  }

  void getStatus () async {
    int status = await vpnManager.getStatus();

    print("status: $status");
    isOn = status == 1;

    notifyListeners();
  }

  void togglePowerButton() async {
    await vpnManager.toggle();

    isOn = !isOn;

    notifyListeners();
  }
}
