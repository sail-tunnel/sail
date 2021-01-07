// To parse this JSON data, do
//
//     final userSubscribeEntity = userSubscribeEntityFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class UserSubscribeEntity {
  UserSubscribeEntity({
    @required this.id,
    @required this.inviteUserId,
    @required this.telegramId,
    @required this.email,
    @required this.password,
    @required this.passwordAlgo,
    @required this.balance,
    @required this.discount,
    @required this.commissionRate,
    @required this.commissionBalance,
    @required this.t,
    @required this.u,
    @required this.d,
    @required this.transferEnable,
    @required this.banned,
    @required this.isAdmin,
    @required this.isStaff,
    @required this.lastLoginAt,
    @required this.lastLoginIp,
    @required this.uuid,
    @required this.groupId,
    @required this.planId,
    @required this.remindExpire,
    @required this.remindTraffic,
    @required this.token,
    @required this.expiredAt,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.plan,
    @required this.subscribeUrl,
    @required this.resetDay,
  });

  final int id;
  final dynamic inviteUserId;
  final dynamic telegramId;
  final String email;
  final String password;
  final dynamic passwordAlgo;
  final int balance;
  final dynamic discount;
  final dynamic commissionRate;
  final int commissionBalance;
  final int t;
  final int u;
  final int d;
  final int transferEnable;
  final int banned;
  final int isAdmin;
  final int isStaff;
  final dynamic lastLoginAt;
  final dynamic lastLoginIp;
  final String uuid;
  final int groupId;
  final int planId;
  final int remindExpire;
  final int remindTraffic;
  final String token;
  final int expiredAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Plan plan;
  final String subscribeUrl;
  final int resetDay;

  UserSubscribeEntity copyWith({
    int id,
    dynamic inviteUserId,
    dynamic telegramId,
    String email,
    String password,
    dynamic passwordAlgo,
    int balance,
    dynamic discount,
    dynamic commissionRate,
    int commissionBalance,
    int t,
    int u,
    int d,
    int transferEnable,
    int banned,
    int isAdmin,
    int isStaff,
    dynamic lastLoginAt,
    dynamic lastLoginIp,
    String uuid,
    int groupId,
    int planId,
    int remindExpire,
    int remindTraffic,
    String token,
    int expiredAt,
    DateTime createdAt,
    DateTime updatedAt,
    Plan plan,
    String subscribeUrl,
    int resetDay,
  }) =>
      UserSubscribeEntity(
        id: id ?? this.id,
        inviteUserId: inviteUserId ?? this.inviteUserId,
        telegramId: telegramId ?? this.telegramId,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordAlgo: passwordAlgo ?? this.passwordAlgo,
        balance: balance ?? this.balance,
        discount: discount ?? this.discount,
        commissionRate: commissionRate ?? this.commissionRate,
        commissionBalance: commissionBalance ?? this.commissionBalance,
        t: t ?? this.t,
        u: u ?? this.u,
        d: d ?? this.d,
        transferEnable: transferEnable ?? this.transferEnable,
        banned: banned ?? this.banned,
        isAdmin: isAdmin ?? this.isAdmin,
        isStaff: isStaff ?? this.isStaff,
        lastLoginAt: lastLoginAt ?? this.lastLoginAt,
        lastLoginIp: lastLoginIp ?? this.lastLoginIp,
        uuid: uuid ?? this.uuid,
        groupId: groupId ?? this.groupId,
        planId: planId ?? this.planId,
        remindExpire: remindExpire ?? this.remindExpire,
        remindTraffic: remindTraffic ?? this.remindTraffic,
        token: token ?? this.token,
        expiredAt: expiredAt ?? this.expiredAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        plan: plan ?? this.plan,
        subscribeUrl: subscribeUrl ?? this.subscribeUrl,
        resetDay: resetDay ?? this.resetDay,
      );

  factory UserSubscribeEntity.fromJson(String str) => UserSubscribeEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserSubscribeEntity.fromMap(Map<String, dynamic> json) => UserSubscribeEntity(
    id: json["id"] == null ? null : json["id"],
    inviteUserId: json["invite_user_id"],
    telegramId: json["telegram_id"],
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
    passwordAlgo: json["password_algo"],
    balance: json["balance"] == null ? null : json["balance"],
    discount: json["discount"],
    commissionRate: json["commission_rate"],
    commissionBalance: json["commission_balance"] == null ? null : json["commission_balance"],
    t: json["t"] == null ? null : json["t"],
    u: json["u"] == null ? null : json["u"],
    d: json["d"] == null ? null : json["d"],
    transferEnable: json["transfer_enable"] == null ? null : json["transfer_enable"],
    banned: json["banned"] == null ? null : json["banned"],
    isAdmin: json["is_admin"] == null ? null : json["is_admin"],
    isStaff: json["is_staff"] == null ? null : json["is_staff"],
    lastLoginAt: json["last_login_at"],
    lastLoginIp: json["last_login_ip"],
    uuid: json["uuid"] == null ? null : json["uuid"],
    groupId: json["group_id"] == null ? null : json["group_id"],
    planId: json["plan_id"] == null ? null : json["plan_id"],
    remindExpire: json["remind_expire"] == null ? null : json["remind_expire"],
    remindTraffic: json["remind_traffic"] == null ? null : json["remind_traffic"],
    token: json["token"] == null ? null : json["token"],
    expiredAt: json["expired_at"] == null ? null : json["expired_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    plan: json["plan"] == null ? null : Plan.fromMap(json["plan"]),
    subscribeUrl: json["subscribe_url"] == null ? null : json["subscribe_url"],
    resetDay: json["reset_day"] == null ? null : json["reset_day"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "invite_user_id": inviteUserId,
    "telegram_id": telegramId,
    "email": email == null ? null : email,
    "password": password == null ? null : password,
    "password_algo": passwordAlgo,
    "balance": balance == null ? null : balance,
    "discount": discount,
    "commission_rate": commissionRate,
    "commission_balance": commissionBalance == null ? null : commissionBalance,
    "t": t == null ? null : t,
    "u": u == null ? null : u,
    "d": d == null ? null : d,
    "transfer_enable": transferEnable == null ? null : transferEnable,
    "banned": banned == null ? null : banned,
    "is_admin": isAdmin == null ? null : isAdmin,
    "is_staff": isStaff == null ? null : isStaff,
    "last_login_at": lastLoginAt,
    "last_login_ip": lastLoginIp,
    "uuid": uuid == null ? null : uuid,
    "group_id": groupId == null ? null : groupId,
    "plan_id": planId == null ? null : planId,
    "remind_expire": remindExpire == null ? null : remindExpire,
    "remind_traffic": remindTraffic == null ? null : remindTraffic,
    "token": token == null ? null : token,
    "expired_at": expiredAt == null ? null : expiredAt,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "plan": plan == null ? null : plan.toMap(),
    "subscribe_url": subscribeUrl == null ? null : subscribeUrl,
    "reset_day": resetDay == null ? null : resetDay,
  };
}

class Plan {
  Plan({
    @required this.id,
    @required this.groupId,
    @required this.transferEnable,
    @required this.name,
    @required this.show,
    @required this.sort,
    @required this.renew,
    @required this.content,
    @required this.monthPrice,
    @required this.quarterPrice,
    @required this.halfYearPrice,
    @required this.yearPrice,
    @required this.twoYearPrice,
    @required this.threeYearPrice,
    @required this.onetimePrice,
    @required this.resetPrice,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final int id;
  final int groupId;
  final int transferEnable;
  final String name;
  final int show;
  final dynamic sort;
  final int renew;
  final String content;
  final int monthPrice;
  final int quarterPrice;
  final int halfYearPrice;
  final int yearPrice;
  final dynamic twoYearPrice;
  final dynamic threeYearPrice;
  final dynamic onetimePrice;
  final int resetPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  Plan copyWith({
    int id,
    int groupId,
    int transferEnable,
    String name,
    int show,
    dynamic sort,
    int renew,
    String content,
    int monthPrice,
    int quarterPrice,
    int halfYearPrice,
    int yearPrice,
    dynamic twoYearPrice,
    dynamic threeYearPrice,
    dynamic onetimePrice,
    int resetPrice,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      Plan(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        transferEnable: transferEnable ?? this.transferEnable,
        name: name ?? this.name,
        show: show ?? this.show,
        sort: sort ?? this.sort,
        renew: renew ?? this.renew,
        content: content ?? this.content,
        monthPrice: monthPrice ?? this.monthPrice,
        quarterPrice: quarterPrice ?? this.quarterPrice,
        halfYearPrice: halfYearPrice ?? this.halfYearPrice,
        yearPrice: yearPrice ?? this.yearPrice,
        twoYearPrice: twoYearPrice ?? this.twoYearPrice,
        threeYearPrice: threeYearPrice ?? this.threeYearPrice,
        onetimePrice: onetimePrice ?? this.onetimePrice,
        resetPrice: resetPrice ?? this.resetPrice,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Plan.fromJson(String str) => Plan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Plan.fromMap(Map<String, dynamic> json) => Plan(
    id: json["id"] == null ? null : json["id"],
    groupId: json["group_id"] == null ? null : json["group_id"],
    transferEnable: json["transfer_enable"] == null ? null : json["transfer_enable"],
    name: json["name"] == null ? null : json["name"],
    show: json["show"] == null ? null : json["show"],
    sort: json["sort"],
    renew: json["renew"] == null ? null : json["renew"],
    content: json["content"] == null ? null : json["content"],
    monthPrice: json["month_price"] == null ? null : json["month_price"],
    quarterPrice: json["quarter_price"] == null ? null : json["quarter_price"],
    halfYearPrice: json["half_year_price"] == null ? null : json["half_year_price"],
    yearPrice: json["year_price"] == null ? null : json["year_price"],
    twoYearPrice: json["two_year_price"],
    threeYearPrice: json["three_year_price"],
    onetimePrice: json["onetime_price"],
    resetPrice: json["reset_price"] == null ? null : json["reset_price"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "group_id": groupId == null ? null : groupId,
    "transfer_enable": transferEnable == null ? null : transferEnable,
    "name": name == null ? null : name,
    "show": show == null ? null : show,
    "sort": sort,
    "renew": renew == null ? null : renew,
    "content": content == null ? null : content,
    "month_price": monthPrice == null ? null : monthPrice,
    "quarter_price": quarterPrice == null ? null : quarterPrice,
    "half_year_price": halfYearPrice == null ? null : halfYearPrice,
    "year_price": yearPrice == null ? null : yearPrice,
    "two_year_price": twoYearPrice,
    "three_year_price": threeYearPrice,
    "onetime_price": onetimePrice,
    "reset_price": resetPrice == null ? null : resetPrice,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
