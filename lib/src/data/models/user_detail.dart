// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) =>
    UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  Data? data;

  UserDetail({
    this.data,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? name;
  int? year;
  String? color;
  String? pantoneValue;

  Data({
    this.id,
    this.name,
    this.year,
    this.color,
    this.pantoneValue,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        year: json["year"],
        color: json["color"],
        pantoneValue: json["pantone_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "year": year,
        "color": color,
        "pantone_value": pantoneValue,
      };
}
