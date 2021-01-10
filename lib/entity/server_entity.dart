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
    @required this.link,
    @required this.lastCheckAt,
  });

  final int id;
  final List<String> groupId;
  final dynamic parentId;
  final List<String> tags;
  final String name;
  final String rate;
  final String host;
  final int port;
  final int serverPort;
  final String cipher;
  final int show;
  final dynamic sort;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String type;
  final String link;
  dynamic lastCheckAt;

  ServerEntity copyWith({
    int id,
    List<int> groupId,
    dynamic parentId,
    List<String> tags,
    String name,
    String rate,
    String host,
    int port,
    int serverPort,
    String cipher,
    int show,
    dynamic sort,
    DateTime createdAt,
    DateTime updatedAt,
    String type,
    String link,
    dynamic lastCheckAt,
  }) =>
      ServerEntity(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        parentId: parentId ?? this.parentId,
        tags: tags ?? this.tags,
        name: name ?? this.name,
        rate: rate ?? this.rate,
        host: host ?? this.host,
        port: port ?? this.port,
        serverPort: serverPort ?? this.serverPort,
        cipher: cipher ?? this.cipher,
        show: show ?? this.show,
        sort: sort ?? this.sort,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        type: type ?? this.type,
        link: link ?? this.link,
        lastCheckAt: lastCheckAt ?? this.lastCheckAt,
      );

  factory ServerEntity.fromJson(String str) =>
      ServerEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServerEntity.fromMap(Map<String, dynamic> map) => ServerEntity(
        id: map["id"] == null ? null : map["id"],
        groupId: map["group_id"] == null
            ? null
            : List<String>.from((map["group_id"] is String
                    ? json.decode(map["group_id"])
                    : map["group_id"])
                .map((x) => x)),
        parentId: map["parent_id"],
        tags: map["tags"] == null
            ? null
            : List<String>.from(
                (map["tags"] is String ? json.decode(map["tags"]) : map["tags"])
                    .map((x) => x)),
        name: map["name"] == null ? null : map["name"],
        rate: map["rate"] == null ? null : map["rate"],
        host: map["host"] == null ? null : map["host"],
        port: map["port"] == null ? null : map["port"],
        serverPort: map["server_port"] == null ? null : map["server_port"],
        cipher: map["cipher"] == null ? null : map["cipher"],
        show: map["show"] == null ? null : map["show"],
        sort: map["sort"],
        createdAt: map["created_at"] == null
            ? null
            : DateTime.parse(map["created_at"]),
        updatedAt: map["updated_at"] == null
            ? null
            : DateTime.parse(map["updated_at"]),
        type: map["type"] == null ? null : map["type"],
        link: map["link"] == null ? null : map["link"],
        lastCheckAt: map["last_check_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "group_id":
            groupId == null ? null : List<dynamic>.from(groupId.map((x) => x)),
        "parent_id": parentId,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "name": name == null ? null : name,
        "rate": rate == null ? null : rate,
        "host": host == null ? null : host,
        "port": port == null ? null : port,
        "server_port": serverPort == null ? null : serverPort,
        "cipher": cipher == null ? null : cipher,
        "show": show == null ? null : show,
        "sort": sort,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "type": type == null ? null : type,
        "link": link == null ? null : link,
        "last_check_at": lastCheckAt,
      };
}
