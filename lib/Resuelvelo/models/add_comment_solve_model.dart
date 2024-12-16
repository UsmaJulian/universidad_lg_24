// To parse this JSON data, do
//
//     final addCommentSolveModel = addCommentSolveModelFromJson(jsonString);

import 'dart:convert';

AddCommentSolveModel addCommentSolveModelFromJson(String str) =>
    AddCommentSolveModel.fromJson(json.decode(str) as Map<String, dynamic>);

String addCommentSolveModelToJson(AddCommentSolveModel data) =>
    json.encode(data.toJson());

class AddCommentSolveModel {
  AddCommentSolveModel({
    required this.response,
    required this.body,
  });

  factory AddCommentSolveModel.fromJson(Map<String, dynamic> json) =>
      AddCommentSolveModel(
        response: Response.fromJson(json['response'] as Map<String, dynamic>),
        body: Body.fromJson(json['body'] as Map<String, dynamic>),
      );
  Response? response;
  Body? body;

  Map<String, dynamic> toJson() => {
        'response': response?.toJson(),
        'body': body?.toJson(),
      };
}

class Body {
  Body({
    required this.idInt,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        idInt: json['id_int'].toString(),
      );
  String? idInt;

  Map<String, dynamic> toJson() => {
        'id_int': idInt,
      };
}

class Response {
  Response({
    required this.type,
    required this.code,
    required this.message,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
      );
  String? type;
  int? code;
  String? message;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
      };
}
