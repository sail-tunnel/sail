import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sail/adapters/leaf_ffi/config.dart';
import 'package:sail/channels/vpn_manager.dart';
import 'package:sail/constant/app_colors.dart';
import 'package:sail/constant/app_strings.dart';
import 'package:sail/models/base_model.dart';
import 'package:sail/models/server_model.dart';
import 'package:sail/models/user_model.dart';
import 'package:sail/utils/common_util.dart';

class AppModel extends BaseModel {
  VpnManager vpnManager = VpnManager();
  VpnStatus vpnStatus = VpnStatus.disconnected;
  bool isOn = false;
  DateTime? connectedDate;
  PageController pageController = PageController(initialPage: 0);
  String appTitle = AppStrings.appName;
  Config config = Config();
  ThemeData themeData = ThemeData(
    primarySwatch: AppColors.themeColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  AppModel() {
    General general = General(
        loglevel: 'info',
        logoutput: '{{leafLogFile}}',
        dnsServer: ['223.5.5.5', '114.114.114.114'],
        tunFd: '{{tunFd}}',
        routingDomainResolve: true);

    List<Proxy> proxies = [];

    proxies.add(Proxy(tag: 'Direct', protocol: 'direct'));
    proxies.add(Proxy(tag: 'Reject', protocol: 'reject'));

    List<Rule> rules = [];

    rules.add(Rule(typeField: 'EXTERNAL', target: 'Direct', filter: 'site:geolocation-!cn'));
    rules.add(Rule(typeField: 'EXTERNAL', target: 'Direct', filter: 'site:cn'));
    rules.add(Rule(typeField: 'FINAL', target: 'Direct'));

    config.general = general;
    config.proxies = proxies;
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
    vpnStatus = await vpnManager.getStatus();

    if (vpnStatus == VpnStatus.connected) {
      isOn = true;

      getConnectedDate();
      notifyListeners();
    } else if (vpnStatus == VpnStatus.disconnected) {
      isOn = false;
      notifyListeners();
    }
  }

  void getConnectedDate() async {
    var date = await vpnManager.getConnectedDate();

    print("date: $date");

    connectedDate = date;
  }

  void togglePowerButton() async {
    if (vpnStatus == VpnStatus.connecting) {
      Fluttertoast.showToast(
          msg: "正在连接中，请稍后...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 14.0);
      return;
    }

    if (vpnStatus == VpnStatus.disconnecting) {
      Fluttertoast.showToast(
          msg: "正在断开中，请稍后...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 14.0);
      return;
    }

    if (vpnStatus == VpnStatus.connected) {
      vpnStatus = VpnStatus.disconnecting;
    }

    if (vpnStatus == VpnStatus.disconnected) {
      vpnStatus = VpnStatus.connecting;
    }

    await vpnManager.toggle();

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
    List<Proxy> proxies = config.proxies!;
    List<ProxyGroup> proxyGroups = [];
    List<String> actors = [];

    for (var server in serverModel.serverEntityList) {
      Proxy proxy = Proxy(
          tag: server.name,
          protocol: server.type,
          address: server.host,
          port: server.port,
          encryptMethod: server.cipher,
          password: userModel.userEntity!.uuid);
      proxies.add(proxy);
      actors.add(server.name);
    }

    if (actors.isNotEmpty) {
      proxyGroups.add(ProxyGroup(
          tag: "UrlTest",
          protocol: 'url-test',
          actors: actors,
          checkInterval: 600));
    }

    if (serverModel.selectServerEntity != null) {
      config.rules?.first.target = serverModel.selectServerEntity!.name;
    } else if (proxyGroups.isNotEmpty) {
      config.rules?.first.target = 'UrlTest';
    } else {
      config.rules?.first.target = 'Direct';
    }

    config.proxies = proxies;
    config.proxyGroups = proxyGroups;

    print("-----------------config-----------------");
    print(config);
    print("-----------------config-----------------");

    vpnManager.setTunnelConfiguration(config.toString());
  }

  void setConfigRule(String tag) async {
    var proxy = config.proxies?.where((proxies) => proxies.tag == tag);
    print("proxy: $proxy");

    if (proxy == null || proxy.isEmpty) {
      // TODO: 弹窗提示
      return;
    }

    config.rules?.first.target = tag;

    print("-----------------config-----------------");
    print(config);
    print("-----------------config-----------------");

    vpnManager.setTunnelConfiguration(config.toString());
  }
}
