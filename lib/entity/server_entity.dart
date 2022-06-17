// To parse this JSON data, do
//
//     final serverEntity = serverEntityFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ServerEntity> serverEntityFromList(List<dynamic> data) =>
    List<ServerEntity>.from(data.map((x) => ServerEntity.fromMap((x))));

class ServerEntity {
  ServerEntity({
    @required this.id,
    @required this.groupId,
    @required this.parentId,
    @required this.tags,
    @required this.name,
    @required this.rate,
    @required this.host,
    @required this.port,
    @required this.serverPort,
    @required this.cipher,
    @required this.show,
    @required this.sort,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.type,
    @required this.lastCheckAt,
  });

  final int id;
  final List<String> groupId;
  final int parentId;
  final List<String> tags;
  final String name;
  final String rate;
  final Host host;
  final int port;
  final int serverPort;
  final Cipher cipher;
  final int show;
  final int sort;
  final int createdAt;
  final int updatedAt;
  final Type type;
  final String lastCheckAt;

  factory ServerEntity.fromJson(String str) => ServerEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServerEntity.fromMap(Map<String, dynamic> json) => ServerEntity(
    id: json["id"],
    groupId: List<String>.from(json["group_id"]?.map((x) => x)),
    parentId: json["parent_id"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    name: json["name"],
    rate: json["rate"],
    host: hostValues.map[json["host"]],
    port: json["port"],
    serverPort: json["server_port"],
    cipher: cipherValues.map[json["cipher"]],
    show: json["show"],
    sort: json["sort"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    type: typeValues.map[json["type"]],
    lastCheckAt: json["last_check_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "group_id": List<dynamic>.from(groupId.map((x) => x)),
    "parent_id": parentId,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "name": name,
    "rate": rate,
    "host": hostValues.reverse[host],
    "port": port,
    "server_port": serverPort,
    "cipher": cipherValues.reverse[cipher],
    "show": show,
    "sort": sort,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "type": typeValues.reverse[type],
    "last_check_at": lastCheckAt,
  };
}

enum Cipher { AES_256_GCM, AES_128_GCM }

final cipherValues = EnumValues({
  "aes-128-gcm": Cipher.AES_128_GCM,
  "aes-256-gcm": Cipher.AES_256_GCM
});

enum Host { ANYCAST_XTCPDNS_AS4812_COM }

final hostValues = EnumValues({
  "anycast.xtcpdns.as4812.com": Host.ANYCAST_XTCPDNS_AS4812_COM
});

enum Type { SHADOWSOCKS }

final typeValues = EnumValues({
  "shadowsocks": Type.SHADOWSOCKS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
