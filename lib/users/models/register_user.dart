// To parse this JSON data, do
//
//     final registerUser = registerUserFromJson(jsonString);

import 'dart:convert';

RegisterUser registerUserFromJson(String str) =>
    RegisterUser.fromJson(json.decode(str) as Map<String, dynamic>);

String registerUserToJson(RegisterUser data) => json.encode(data.toJson());

class RegisterUser {
  RegisterUser({
    required this.statusRegister,
    required this.body,
  });

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        statusRegister:
            StatusRegister.fromJson(json['status'] as Map<String, dynamic>),
        body: Body.fromJson(json['body'] as Map<String, dynamic>),
      );
  StatusRegister statusRegister;
  Body body;

  Map<String, dynamic> toJson() => {
        'status': statusRegister.toJson(),
        'body': body.toJson(),
      };
}

class Body {
  Body({
    required this.userId,
    required this.email,
    required this.username,
    required this.token,
    required this.role,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        userId: json['userId'].toString(),
        email: json['email'].toString(),
        username: json['username'].toString(),
        token: json['token'].toString(),
        role: json['role'].toString(),
      );
  String userId;
  String email;
  String username;
  String token;
  String role;

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'email': email,
        'username': username,
        'token': token,
        'role': role,
      };
}

class StatusRegister {
  StatusRegister({
    required this.type,
    required this.code,
    required this.message,
  });

  factory StatusRegister.fromJson(Map<String, dynamic> json) => StatusRegister(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
      );
  String type;
  int code;
  String message;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
      };
}
