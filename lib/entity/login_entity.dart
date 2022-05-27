// To parse this JSON data, do
//
//     final loginEntity = loginEntityFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class LoginEntity {
  LoginEntity({
    @required this.token,
    @required this.authToken,
  });

  final String token;
  final String authToken;

  factory LoginEntity.fromJson(String str) => LoginEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginEntity.fromMap(Map<String, dynamic> json) => LoginEntity(
    token: json["token"],
    authToken: json["auth_token"],
  );

  Map<String, dynamic> toMap() => {
    "token": token,
    "auth_token": authToken,
  };
}
