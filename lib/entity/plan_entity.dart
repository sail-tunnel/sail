// To parse this JSON data, do
//
//     final planEntity = planEntityFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PlanEntity> planEntityFromList(List data) => List<PlanEntity>.from(data.map((x) => PlanEntity.fromMap(x)));

class PlanEntity {
  PlanEntity({
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
  final dynamic monthPrice;
  final dynamic quarterPrice;
  final dynamic halfYearPrice;
  final dynamic yearPrice;
  final dynamic twoYearPrice;
  final dynamic threeYearPrice;
  final dynamic onetimePrice;
  final dynamic resetPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  PlanEntity copyWith({
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
      PlanEntity(
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

  factory PlanEntity.fromJson(String str) => PlanEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlanEntity.fromMap(Map<String, dynamic> json) => PlanEntity(
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
