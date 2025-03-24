// To parse this JSON data, do
//
//     final saveResuelveloTestModel = saveResuelveloTestModelFromJson(jsonString);

import 'dart:convert';

SaveResuelveloTestModel saveResuelveloTestModelFromJson(String str) =>
    SaveResuelveloTestModel.fromJson(json.decode(str) as Map<String, dynamic>);

String saveResuelveloTestModelToJson(SaveResuelveloTestModel data) =>
    json.encode(data.toJson());

class SaveResuelveloTestModel {
  SaveResuelveloTestModel({
    required this.response,
    required this.body,
  });

  factory SaveResuelveloTestModel.fromJson(Map<String, dynamic> json) =>
      SaveResuelveloTestModel(
        response: Response.fromJson(json['response'] as Map<String, dynamic>),
        body: Body.fromJson(json['body'] as Map<String, dynamic>),
      );
  Response response;
  Body body;

  Map<String, dynamic> toJson() => {
        'response': response.toJson(),
        'body': body.toJson(),
      };
}

class Body {
  Body({
    required this.correctas,
    required this.puntos,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        correctas: json['correctas'].toString(),
        puntos: int.parse(json['puntos'].toString()),
      );
  String correctas;
  int puntos;

  Map<String, dynamic> toJson() => {
        'correctas': correctas,
        'puntos': puntos,
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
  String type;
  int code;
  String message;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
      };
}
