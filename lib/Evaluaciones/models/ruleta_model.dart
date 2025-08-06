// To parse this JSON data, do
//
//     final ruletaResponseModel = ruletaResponseModelFromJson(jsonString);

import 'dart:convert';

RuletaResponseModel ruletaResponseModelFromJson(String str) =>
    RuletaResponseModel.fromJson(json.decode(str) as Map<String, dynamic>);

String ruletaResponseModelToJson(RuletaResponseModel data) =>
    json.encode(data.toJson());

class RuletaResponseModel {
  RuletaResponseModel({
    this.response,
    this.body,
  });

  factory RuletaResponseModel.fromJson(Map<String, dynamic> json) =>
      RuletaResponseModel(
        response: json['response'] == null
            ? null
            : Response.fromJson(json['response'] as Map<String, dynamic>),
        body: json['body'] == null
            ? null
            : Body.fromJson(json['body'] as Map<String, dynamic>),
      );
  Response? response;
  Body? body;

  RuletaResponseModel copyWith({
    Response? response,
    Body? body,
  }) =>
      RuletaResponseModel(
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
    this.listado,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        listado: json['listado'] == null
            ? []
            : List<Listado>.from(
                (json['listado'] as List<dynamic>)
                    .map((x) => Listado.fromJson(x as Map<String, dynamic>)),
              ),
      );
  List<Listado>? listado;

  Body copyWith({
    List<Listado>? listado,
  }) =>
      Body(
        listado: listado ?? this.listado,
      );

  Map<String, dynamic> toJson() => {
        'listado': listado == null
            ? <dynamic>[]
            : List<dynamic>.from(listado!.map((x) => x.toJson())),
      };
}

class Listado {
  Listado({
    this.tid,
    this.name,
    this.color,
  });

  factory Listado.fromJson(Map<String, dynamic> json) => Listado(
        tid: json['tid'].toString(),
        name: json['name'].toString(),
        color: json['color'].toString(),
      );
  String? tid;
  String? name;
  String? color;

  Listado copyWith({
    String? tid,
    String? name,
    String? color,
  }) =>
      Listado(
        tid: tid ?? this.tid,
        name: name ?? this.name,
        color: color ?? this.color,
      );

  Map<String, dynamic> toJson() => {
        'tid': tid,
        'name': name,
        'color': color,
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
