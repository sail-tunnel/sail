// To parse this JSON data, do
//
//     final loginEntity = loginEntityFromMap(jsonString);

import 'dart:convert';

class LoginEntity {
  LoginEntity({
    required this.token,
    required this.authData,
  });

  final String token;
  final String authData;

  factory LoginEntity.fromJson(String str) => LoginEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginEntity.fromMap(Map<String, dynamic> json) => LoginEntity(
    token: json["token"],
    authData: json["auth_data"],
  );

  Map<String, dynamic> toMap() => {
    "token": token,
    "auth_token": authData,
  };
}
