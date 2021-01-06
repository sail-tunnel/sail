// To parse this JSON data, do
//
//     final loginEntity = loginEntityFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class LoginEntity {
  LoginEntity({
    @required this.token,
    @required this.isAdmin,
  });

  final String token;
  final bool isAdmin;

  LoginEntity copyWith({
    String token,
    bool isAdmin,
  }) =>
      LoginEntity(
        token: token ?? this.token,
        isAdmin: isAdmin ?? this.isAdmin,
      );

  factory LoginEntity.fromJson(String str) => LoginEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginEntity.fromMap(Map<String, dynamic> json) => LoginEntity(
    token: json["token"],
    isAdmin: json["is_admin"],
  );

  Map<String, dynamic> toMap() => {
    "token": token,
    "is_admin": isAdmin,
  };
}
