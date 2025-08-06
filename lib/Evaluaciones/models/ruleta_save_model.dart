// To parse this JSON data, do
//
//     final ruletaSaveResponseModel = ruletaSaveResponseModelFromJson(jsonString);

import 'dart:convert';

RuletaSaveResponseModel ruletaSaveResponseModelFromJson(String str) =>
    RuletaSaveResponseModel.fromJson(json.decode(str) as Map<String, dynamic>);

String ruletaSaveResponseModelToJson(RuletaSaveResponseModel data) =>
    json.encode(data.toJson());

class RuletaSaveResponseModel {
  RuletaSaveResponseModel({
    this.response,
    this.body,
  });

  factory RuletaSaveResponseModel.fromJson(Map<String, dynamic> json) =>
      RuletaSaveResponseModel(
        response: json['response'] == null
            ? null
            : Response.fromJson(json['response'] as Map<String, dynamic>),
        body: json['body'] == null
            ? null
            : Body.fromJson(json['body'] as Map<String, dynamic>),
      );
  Response? response;
  Body? body;

  RuletaSaveResponseModel copyWith({
    Response? response,
    Body? body,
  }) =>
      RuletaSaveResponseModel(
        response: response ?? this.response,
        body: body ?? this.body,
      );

  Map<String, dynamic> toJson() => {
        'response': response?.toJson(),
        'body': body?.toJson(),
      };
}

class Body {
  Body({
    this.result,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        result: json['result'].toString(),
      );
  String? result;

  Body copyWith({
    String? result,
  }) =>
      Body(
        result: result ?? this.result,
      );

  Map<String, dynamic> toJson() => {
        'result': result,
      };
}

class Response {
  Response({
    this.type,
    this.code,
    this.message,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
      );
  String? type;
  int? code;
  String? message;

  Response copyWith({
    String? type,
    int? code,
    String? message,
  }) =>
      Response(
        type: type ?? this.type,
        code: code ?? this.code,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
      };
}
