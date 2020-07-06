import 'dart:convert';

class User {
  String uid;
  String username;
  String photo;
  int friendLength;
  String isArkadas;

  User({this.uid, this.username, this.photo, this.friendLength, this.isArkadas});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
    uid: json["uid"] == null ? null : json["uid"],
    username: json["name"] == null ? null : json["name"],
    photo: json["photo"] == null ? null : json["photo"],
    friendLength: json["friendLength"] == null ? null : json["friendLength"],
    isArkadas: json["isArkadas"] == null ? null : json["isArkadas"],
  );
}