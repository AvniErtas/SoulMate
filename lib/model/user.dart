import 'dart:convert';

class User {
  String uid;
  String username;
  String photo;
  String test_score;

  User({this.uid, this.username, this.photo, this.test_score});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  factory User.fromJson(Map<String, dynamic> json) => User(
    uid: json["uid"] == null ? null : json["uid"],
    username: json["name"] == null ? null : json["name"],
    photo: json["photo"] == null ? null : json["photo"],
  );
}