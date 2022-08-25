// To parse this JSON data, do
//
//     final userEntity = userEntityFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserEntity {
  UserEntity({
    required this.email,
    required this.transferEnable,
    required this.lastLoginAt,
    required this.createdAt,
    required this.banned,
    required this.remindExpire,
    required this.remindTraffic,
    required this.expiredAt,
    required this.balance,
    required this.commissionBalance,
    required this.planId,
    @required this.discount,
    @required this.commissionRate,
    @required this.telegramId,
    required this.uuid,
    required this.avatarUrl,
  });

  final String email;
  final int transferEnable;
  final DateTime? lastLoginAt;
  final DateTime? createdAt;
  final int banned;
  final int remindExpire;
  final int remindTraffic;
  final DateTime? expiredAt;
  final int balance;
  final int commissionBalance;
  final int planId;
  final dynamic discount;
  final dynamic commissionRate;
  final dynamic telegramId;
  final String uuid;
  final String avatarUrl;

  factory UserEntity.fromJson(String str) => UserEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
    email: json["email"],
    transferEnable: json["transfer_enable"],
    lastLoginAt: json["last_login_at"] == null ? null : DateTime.fromMillisecondsSinceEpoch(json["last_login_at"] * 1000),
    createdAt: json["created_at"] == null ? null : DateTime.fromMillisecondsSinceEpoch(json["created_at"] * 1000),
    banned: json["banned"],
    remindExpire: json["remind_expire"],
    remindTraffic: json["remind_traffic"],
    expiredAt: json["expired_at"] == null ? null : DateTime.fromMillisecondsSinceEpoch(json["expired_at"] * 1000),
    balance: json["balance"],
    commissionBalance: json["commission_balance"],
    planId: json["plan_id"],
    discount: json["discount"],
    commissionRate: json["commission_rate"],
    telegramId: json["telegram_id"],
    uuid: json["uuid"],
    avatarUrl: json["avatar_url"],
  );

  Map<String, dynamic> toMap() => {
    "email": email,
    "transfer_enable": transferEnable,
    "last_login_at": lastLoginAt == null ? null : lastLoginAt!.millisecondsSinceEpoch ~/ 1000,
    "created_at": createdAt == null ? null : createdAt!.millisecondsSinceEpoch ~/ 1000,
    "banned": banned,
    "remind_expire": remindExpire,
    "remind_traffic": remindTraffic,
    "expired_at": expiredAt == null ? null : expiredAt!.millisecondsSinceEpoch ~/ 1000,
    "balance": balance,
    "commission_balance": commissionBalance,
    "plan_id": planId,
    "discount": discount,
    "commission_rate": commissionRate,
    "telegram_id": telegramId,
    "uuid": uuid,
    "avatar_url": avatarUrl,
  };
}
