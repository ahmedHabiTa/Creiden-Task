// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  Data data;
  bool status;
  String message;
  int code;

  LoginResponse({
    required this.data,
    required this.status,
    required this.message,
    required this.code,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
        "code": code,
      };
}

class Data {
  User user;
  String token;

  Data({
    required this.user,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  int id;
  String name;
  String email;
  List<Role> roles;
  dynamic image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "image": image,
      };
}

class Role {
  int id;
  String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
