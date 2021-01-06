// To parse this JSON data, do
//
//     final userSubscribeEntity = userSubscribeEntityFromJson(jsonString);

import 'dart:convert';

class UserSubscribeEntity {
  UserSubscribeEntity({
    this.id,
    this.inviteUserId,
    this.telegramId,
    this.email,
    this.password,
    this.passwordAlgo,
    this.balance,
    this.discount,
    this.commissionRate,
    this.commissionBalance,
    this.t,
    this.u,
    this.d,
    this.transferEnable,
    this.banned,
    this.isAdmin,
    this.isStaff,
    this.lastLoginAt,
    this.lastLoginIp,
    this.uuid,
    this.groupId,
    this.planId,
    this.remindExpire,
    this.remindTraffic,
    this.token,
    this.expiredAt,
    this.createdAt,
    this.updatedAt,
    this.plan,
    this.subscribeUrl,
    this.resetDay,
  });

  int id;
  dynamic inviteUserId;
  dynamic telegramId;
  String email;
  String password;
  dynamic passwordAlgo;
  int balance;
  dynamic discount;
  dynamic commissionRate;
  int commissionBalance;
  int t;
  int u;
  int d;
  int transferEnable;
  int banned;
  int isAdmin;
  int isStaff;
  dynamic lastLoginAt;
  dynamic lastLoginIp;
  String uuid;
  int groupId;
  int planId;
  int remindExpire;
  int remindTraffic;
  String token;
  int expiredAt;
  DateTime createdAt;
  DateTime updatedAt;
  Plan plan;
  String subscribeUrl;
  int resetDay;

  factory UserSubscribeEntity.fromRawJson(String str) => UserSubscribeEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSubscribeEntity.fromJson(Map<String, dynamic> json) => UserSubscribeEntity(
    id: json["id"],
    inviteUserId: json["invite_user_id"],
    telegramId: json["telegram_id"],
    email: json["email"],
    password: json["password"],
    passwordAlgo: json["password_algo"],
    balance: json["balance"],
    discount: json["discount"],
    commissionRate: json["commission_rate"],
    commissionBalance: json["commission_balance"],
    t: json["t"],
    u: json["u"],
    d: json["d"],
    transferEnable: json["transfer_enable"],
    banned: json["banned"],
    isAdmin: json["is_admin"],
    isStaff: json["is_staff"],
    lastLoginAt: json["last_login_at"],
    lastLoginIp: json["last_login_ip"],
    uuid: json["uuid"],
    groupId: json["group_id"],
    planId: json["plan_id"],
    remindExpire: json["remind_expire"],
    remindTraffic: json["remind_traffic"],
    token: json["token"],
    expiredAt: json["expired_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    plan: Plan.fromJson(json["plan"]),
    subscribeUrl: json["subscribe_url"],
    resetDay: json["reset_day"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invite_user_id": inviteUserId,
    "telegram_id": telegramId,
    "email": email,
    "password": password,
    "password_algo": passwordAlgo,
    "balance": balance,
    "discount": discount,
    "commission_rate": commissionRate,
    "commission_balance": commissionBalance,
    "t": t,
    "u": u,
    "d": d,
    "transfer_enable": transferEnable,
    "banned": banned,
    "is_admin": isAdmin,
    "is_staff": isStaff,
    "last_login_at": lastLoginAt,
    "last_login_ip": lastLoginIp,
    "uuid": uuid,
    "group_id": groupId,
    "plan_id": planId,
    "remind_expire": remindExpire,
    "remind_traffic": remindTraffic,
    "token": token,
    "expired_at": expiredAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "plan": plan.toJson(),
    "subscribe_url": subscribeUrl,
    "reset_day": resetDay,
  };
}

class Plan {
  Plan({
    this.id,
    this.groupId,
    this.transferEnable,
    this.name,
    this.show,
    this.sort,
    this.renew,
    this.content,
    this.monthPrice,
    this.quarterPrice,
    this.halfYearPrice,
    this.yearPrice,
    this.twoYearPrice,
    this.threeYearPrice,
    this.onetimePrice,
    this.resetPrice,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int groupId;
  int transferEnable;
  String name;
  int show;
  dynamic sort;
  int renew;
  String content;
  int monthPrice;
  int quarterPrice;
  int halfYearPrice;
  int yearPrice;
  dynamic twoYearPrice;
  dynamic threeYearPrice;
  dynamic onetimePrice;
  int resetPrice;
  DateTime createdAt;
  DateTime updatedAt;

  factory Plan.fromRawJson(String str) => Plan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
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
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
