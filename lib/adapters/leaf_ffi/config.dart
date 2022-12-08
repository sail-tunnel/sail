import 'dart:collection';

class Config {
  General? general;
  List<Proxy>? proxies;
  List<ProxyGroup>? proxyGroups;
  List<Rule>? rules;
  HashMap<String, List<String>>? hosts;

  @override
  String toString() {
    String result = "";

    if (general != null) {
      result += "$general\n";
    }

    if (proxies != null && proxies!.isNotEmpty) {
      result += "[Proxy]\n";
      result += proxies!.map((e) => e.toString()).join("\n");
      result += "\n\n";
    }

    if (proxyGroups != null && proxyGroups!.isNotEmpty) {
      result += "[Proxy Group]\n";
      result += proxyGroups!.map((e) => e.toString()).join("\n");
      result += "\n\n";
    }

    if (rules != null && rules!.isNotEmpty) {
      result += "[Rule]\n";
      result += rules!.map((e) => e.toString()).join("\n");
      result += "\n\n";
    }

    if (hosts != null && hosts!.isNotEmpty) {
      result += "[Host]\n";
      result += hosts!.entries
          .map((e) => "${e.key} = ${e.value.join(", ")}")
          .join("\n");
      result += "\n\n";
    }

    return result;
  }
}

class Rule {
  Rule({required this.typeField, this.filter, required this.target});

  String typeField;
  String? filter;
  String target;

  @override
  String toString() {
    String result = typeField;

    if (filter != null) {
      result += ', $filter';
    }

    result += ', $target';

    return result;
  }
}

class ProxyGroup {
  ProxyGroup(
      {required this.tag,
      required this.protocol,
      this.actors,
      this.healthCheck,
      this.checkInterval,
      this.failTimeout,
      this.failover,
      this.fallbackCache,
      this.cacheSize,
      this.cacheTimeout,
      this.lastResort,
      this.healthCheckTimeout,
      this.healthCheckDelay,
      this.healthCheckActive,
      this.delayBase,
      this.method});

  String tag;
  String protocol;
  List<String>? actors;

  /// failover
  bool? healthCheck;
  int? checkInterval;
  int? failTimeout;
  bool? failover;
  bool? fallbackCache;
  int? cacheSize;
  int? cacheTimeout;
  String? lastResort;
  int? healthCheckTimeout;
  int? healthCheckDelay;
  int? healthCheckActive;

  /// tryall
  int? delayBase;

  /// static
  String? method;

  @override
  String toString() {
    String result = tag;

    result += " = $protocol";

    if (actors != null) {
      result += ", ${actors!.join(", ")}";
    }

    if (healthCheck != null) {
      result += ", health-check = $healthCheck";
    }

    if (checkInterval != null) {
      result += ", check-interval = $checkInterval";
    }

    if (failTimeout != null) {
      result += ", fail-timeout = $failTimeout";
    }

    if (failover != null) {
      result += ", failover = $failover";
    }

    if (fallbackCache != null) {
      result += ", fallback-cache = $fallbackCache";
    }

    if (cacheSize != null) {
      result += ", cache-size = $cacheSize";
    }

    if (cacheTimeout != null) {
      result += ", cache-timeout = $cacheTimeout";
    }

    if (lastResort != null) {
      result += ", last-resort = $lastResort";
    }

    if (healthCheckTimeout != null) {
      result += ", health-check-timeout = $healthCheckTimeout";
    }

    if (healthCheckDelay != null) {
      result += ", health-check-delay = $healthCheckDelay";
    }

    if (healthCheckActive != null) {
      result += ", health-check-active = $healthCheckActive";
    }

    if (delayBase != null) {
      result += ", delay-base = $delayBase";
    }

    if (method != null) {
      result += ", method = $method";
    }

    return result;
  }
}

class Proxy {
  Proxy(
      {required this.tag,
      required this.protocol,
      this.interface,
      this.address,
      this.port,
      this.encryptMethod,
      this.password,
      this.ws,
      this.tls,
      this.tlsCert,
      this.wsPath,
      this.wsHost,
      this.sni,
      this.username,
      this.amux,
      this.amuxMax,
      this.amuxCon,
      this.quic});

  String tag;
  String protocol;
  String? interface;

  /// address
  String? address;
  int? port;

  /// shadowsocks
  String? encryptMethod;

  /// shadowsocks, trojan
  String? password;

  bool? ws;
  bool? tls;
  String? tlsCert;
  String? wsPath;
  String? wsHost;

  /// trojan
  String? sni;

  /// vmess
  String? username;

  bool? amux;
  int? amuxMax;
  int? amuxCon;

  bool? quic;

  @override
  String toString() {
    String result = tag;

    result += " = $protocol";

    switch (protocol) {
      case 'direct':
      case 'drop':
      case 'reject':
        return result;
    }

    if (address != null && port != null) {
      result += ", $address, $port";
    }

    if (encryptMethod != null) {
      result += ", encrypt-method = $encryptMethod";
    }

    if (password != null) {
      result += ", password = $password";
    }

    if (ws != null) {
      result += ", ws = $ws";
    }

    if (tls != null) {
      result += ", tls = $tls";
    }

    if (tlsCert != null) {
      result += ", tls-cert = $tlsCert";
    }

    if (wsPath != null) {
      result += ", ws-path = $wsPath";
    }

    if (wsHost != null) {
      result += ", ws-host = $wsHost";
    }

    if (sni != null) {
      result += ", sni = $sni";
    }

    if (username != null) {
      result += ", username = $username";
    }

    if (amux != null) {
      result += ", amux = $amux";
    }

    if (amuxMax != null) {
      result += ", amux-max = $amuxMax";
    }

    if (amuxCon != null) {
      result += ", amux-con = $amuxCon";
    }

    if (quic != null) {
      result += ", quic = $quic";
    }

    if (interface != null) {
      result += ", interface = $interface";
    }

    return result;
  }
}

class General {
  General(
      {this.tun,
      this.tunFd,
      this.loglevel,
      this.logoutput,
      this.dnsServer,
      this.dnsInterface,
      this.alwaysRealIp,
      this.alwaysFakeIp,
      this.httpInterface,
      this.httpPort,
      this.socksInterface,
      this.socksPort,
      this.apiInterface,
      this.apiPort,
      this.routingDomainResolve});

  Tun? tun;
  dynamic tunFd;
  String? loglevel;
  String? logoutput;
  List<String>? dnsServer;
  String? dnsInterface;
  List<String>? alwaysRealIp;
  List<String>? alwaysFakeIp;
  String? httpInterface;
  int? httpPort;
  String? socksInterface;
  int? socksPort;
  String? apiInterface;
  int? apiPort;
  bool? routingDomainResolve;

  @override
  String toString() {
    String result = "[General]\n";

    if (tun != null) {
      result += "tun = $tun\n";
    }

    if (tunFd != null) {
      result += "tun-fd = $tunFd\n";
    }

    if (loglevel != null) {
      result += "loglevel = $loglevel\n";
    }

    if (logoutput != null) {
      result += "logoutput = $logoutput\n";
    }

    if (dnsServer != null) {
      result += "dns-server = ${dnsServer!.join(", ")}\n";
    }

    if (dnsInterface != null) {
      result += "dns-interface = $dnsInterface\n";
    }

    if (alwaysRealIp != null) {
      result += "always-real-ip = ${alwaysRealIp!.join(", ")}\n";
    }

    if (alwaysFakeIp != null) {
      result += "always-fake-ip = ${alwaysFakeIp!.join(", ")}\n";
    }

    if (routingDomainResolve != null) {
      result += "routing-domain-resolve = $routingDomainResolve\n";
    }

    if (httpInterface != null) {
      result += "http-interface = $httpInterface\n";
    }

    if (httpPort != null) {
      result += "http-port = $httpPort\n";
    }

    if (socksInterface != null) {
      result += "socks-interface = $socksInterface\n";
    }

    if (socksInterface != null) {
      result += "socks-port = $socksPort\n";
    }

    if (apiInterface != null) {
      result += "api-interface = $apiInterface\n";
    }

    if (apiPort != null) {
      result += "api-port = $apiPort\n";
    }

    return result;
  }
}

class Tun {
  Tun({this.name, this.address, this.netmask, this.gateway, this.mtu});

  String? name;
  String? address;
  String? netmask;
  String? gateway;
  int? mtu;

  @override
  String toString() {
    String result = "";

    if (name == 'auto') {
      result += "auto";

      return result;
    }

    if (name != null &&
        address != null &&
        netmask != null &&
        gateway != null &&
        mtu != null) {
      result += ", $name, $address, $netmask, $gateway, $mtu";
    }

    return result;
  }
}
