// To parse this JSON data, do
//
//     final userSubscribeEntity = userSubscribeEntityFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserSubscribeEntity {
  UserSubscribeEntity({
    required this.planId,
    required this.token,
    required this.expiredAt,
    required this.u,
    required this.d,
    required this.transferEnable,
    required this.email,
    required this.plan,
    required this.subscribeUrl,
    required this.resetDay,
  });

  final int planId;
  final String token;
  final int expiredAt;
  final int u;
  final int d;
  final int transferEnable;
  final String email;
  final Plan plan;
  final String subscribeUrl;
  final int? resetDay;

  factory UserSubscribeEntity.fromJson(String str) => UserSubscribeEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserSubscribeEntity.fromMap(Map<String, dynamic> json) => UserSubscribeEntity(
    planId: json["plan_id"],
    token: json["token"],
    expiredAt: json["expired_at"],
    u: json["u"],
    d: json["d"],
    transferEnable: json["transfer_enable"],
    email: json["email"],
    plan: Plan.fromMap(json["plan"]),
    subscribeUrl: json["subscribe_url"],
    resetDay: json["reset_day"],
  );

  Map<String, dynamic> toMap() => {
    "plan_id": planId,
    "token": token,
    "expired_at": expiredAt,
    "u": u,
    "d": d,
    "transfer_enable": transferEnable,
    "email": email,
    "plan": plan.toMap(),
    "subscribe_url": subscribeUrl,
    "reset_day": resetDay,
  };
}

class Plan {
  Plan({
    required this.id,
    required this.groupId,
    required this.transferEnable,
    required this.name,
    required this.show,
    required this.sort,
    required this.renew,
    required this.content,
    required this.monthPrice,
    required this.quarterPrice,
    required this.halfYearPrice,
    required this.yearPrice,
    required this.twoYearPrice,
    required this.threeYearPrice,
    required this.onetimePrice,
    required this.resetPrice,
    required this.resetTrafficMethod,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int groupId;
  final int transferEnable;
  final String name;
  final int show;
  final int? sort;
  final int renew;
  final String? content;
  final int? monthPrice;
  final int? quarterPrice;
  final int? halfYearPrice;
  final int? yearPrice;
  final int? twoYearPrice;
  final int? threeYearPrice;
  final int? onetimePrice;
  final int? resetPrice;
  final int? resetTrafficMethod;
  final int? createdAt;
  final int? updatedAt;

  factory Plan.fromJson(String str) => Plan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Plan.fromMap(Map<String, dynamic> json) => Plan(
    id: json["id"],
    groupId: json["group_id"],
    transferEnable: json["transfer_enable"],
    name: json["name"],
    show: json["show"],
    sort: json["sort"],
    renew: json["renew"],
    content: json["content"],
    monthPrice: json["month_price"],
    quarterPrice: json["quarter_price"],
    halfYearPrice: json["half_year_price"],
    yearPrice: json["year_price"],
    twoYearPrice: json["two_year_price"],
    threeYearPrice: json["three_year_price"],
    onetimePrice: json["onetime_price"],
    resetPrice: json["reset_price"],
    resetTrafficMethod: json["reset_traffic_method"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "group_id": groupId,
    "transfer_enable": transferEnable,
    "name": name,
    "show": show,
    "sort": sort,
    "renew": renew,
    "content": content,
    "month_price": monthPrice,
    "quarter_price": quarterPrice,
    "half_year_price": halfYearPrice,
    "year_price": yearPrice,
    "two_year_price": twoYearPrice,
    "three_year_price": threeYearPrice,
    "onetime_price": onetimePrice,
    "reset_price": resetPrice,
    "reset_traffic_method": resetTrafficMethod,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
