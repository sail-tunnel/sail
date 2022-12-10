import 'package:flutter/material.dart';
import 'package:sail/adapters/leaf_ffi/config.dart';
import 'package:sail/channels/vpn_manager.dart';
import 'package:sail/constant/app_strings.dart';
import 'package:sail/models/base_model.dart';
import 'package:sail/models/server_model.dart';
import 'package:sail/models/user_model.dart';
import 'package:sail/utils/common_util.dart';

class AppModel extends BaseModel {
  VpnManager vpnManager = VpnManager();
  bool isOn = false;
  PageController pageController = PageController(initialPage: 0);
  String appTitle = 'Sail';
  Config config = Config();

  AppModel() {
    General general = General(
        loglevel: 'info',
        logoutput: '{{leafLogFile}}',
        dnsServer: ['223.5.5.5', '114.114.114.114'],
        tunFd: '{{tunFd}}',
        routingDomainResolve: true);

    List<Rule> rules = [];
    // rules.add(Rule(typeField: 'EXTERNAL', target: 'Direct', filter: 'site:cn'));
    rules.add(Rule(typeField: 'FINAL', target: 'Direct'));

    config.general = general;
    config.rules = rules;
  }

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

  void getStatus() async {
    isOn = await vpnManager.getStatus();

    print("status: $isOn");

    notifyListeners();
  }

  void togglePowerButton() async {
    await vpnManager.toggle();

    isOn = !isOn;

    notifyListeners();
  }

  void getTunnelLog() async {
    var log = await vpnManager.getTunnelLog();

    print("log: $log");
  }

  void getTunnelConfiguration() async {
    var conf = await vpnManager.getTunnelConfiguration();

    print("config: $conf");
  }

  void setConfigProxies(UserModel userModel, ServerModel serverModel) async {
    List<Proxy> proxies = [];
    List<ProxyGroup> proxyGroups = [];
    List<String> actors = [];

    serverModel.serverEntityList?.forEach((server) {
      Proxy proxy = Proxy(
          tag: server.name,
          protocol: server.type,
          address: server.host,
          port: server.port,
          encryptMethod: server.cipher,
          password: userModel.userEntity!.uuid);
      proxies.add(proxy);
      actors.add(server.name);
    });

    if (actors.isNotEmpty) {
      proxyGroups.add(ProxyGroup(
          tag: "UrlTest",
          protocol: 'url-test',
          actors: actors,
          checkInterval: 600));

      config.rules?.last.target = "UrlTest";
    }

    config.proxies = proxies;
    config.proxyGroups = proxyGroups;

    print("-----------------config-----------------");
    print(config);
    print("-----------------config-----------------");

    vpnManager.setTunnelConfiguration(config.toString());
  }

  void setConfigRule(String tag) async {
    // var proxy = config.proxies?.where((proxies) => proxies.tag == tag);
    //
    // if (proxy == null || proxy.isEmpty) {
    //   return;
    // }
    //
    // config.rules?.last.target = tag;
    //
    // print("-----------------config-----------------");
    // print(config);
    // print("-----------------config-----------------");
    //
    // vpnManager.setTunnelConfiguration(config.toString());
  }
}
