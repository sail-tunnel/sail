// To parse this JSON data, do
//
//     final serverEntity = serverEntityFromMap(jsonString);

import 'dart:convert';

List<ServerEntity> serverEntityFromList(List<dynamic> data) =>
    List<ServerEntity>.from(data.map((x) => ServerEntity.fromMap((x))));

class ServerEntity {
  ServerEntity({
    required this.id,
    required this.groupId,
    required this.parentId,
    required this.tags,
    required this.name,
    required this.rate,
    required this.host,
    required this.port,
    required this.serverPort,
    required this.cipher,
    required this.show,
    required this.sort,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.lastCheckAt,
  });

  final int id;
  final List<String> groupId;
  final int? parentId;
  final List<String> tags;
  final String name;
  final String rate;
  final String host;
  final int port;
  final int serverPort;
  final String? cipher;
  final int show;
  final int? sort;
  Duration? ping;
  final int createdAt;
  final int updatedAt;
  final String type;
  final String? lastCheckAt;

  factory ServerEntity.fromJson(String str) => ServerEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServerEntity.fromMap(Map<String, dynamic> json) => ServerEntity(
    id: json["id"],
    groupId: List<String>.from(json["group_id"]?.map((x) => x) ?? []),
    parentId: json["parent_id"],
    tags: List<String>.from(json["tags"]?.map((x) => x) ?? []),
    name: json["name"],
    rate: json["rate"],
    host: json["host"],
    port: json["port"],
    serverPort: json["server_port"],
    cipher: json["cipher"],
    show: json["show"],
    sort: json["sort"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    type: json["type"],
    lastCheckAt: json["last_check_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "group_id": List<dynamic>.from(groupId.map((x) => x)),
    "parent_id": parentId,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "name": name,
    "rate": rate,
    "host": host,
    "port": port,
    "server_port": serverPort,
    "cipher": cipher,
    "show": show,
    "sort": sort,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "type": type,
    "last_check_at": lastCheckAt,
  };
}
