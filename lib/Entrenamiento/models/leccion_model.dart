// To parse this JSON data, do
//
//     final leccion = leccionFromJson(jsonString);

import 'dart:convert';

Leccion leccionFromJson(String str) =>
    Leccion.fromJson(json.decode(str) as Map<String, dynamic>);

String leccionToJson(Leccion data) => json.encode(data.toJson());

class Leccion {
  Leccion({
    this.status,
  });

  factory Leccion.fromJson(Map<String, dynamic> json) => Leccion(
        status: Status.fromJson(json['status'] as Map<String, dynamic>),
      );

  Status? status;

  Map<String, dynamic> toJson() => {
        'status': status?.toJson(),
      };
}

class Status {
  Status({
    this.type,
    this.code,
    this.message,
    this.data,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        data: Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  String? type;
  int? code;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'data': data?.toJson(),
      };
}

class Data {
  Data({
    this.curso,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        curso: Curso.fromJson(json['curso'] as Map<String, dynamic>),
      );

  Curso? curso;

  Map<String, dynamic> toJson() => {
        'curso': curso?.toJson(),
      };
}

class Curso {
  Curso({
    this.titulo,
    this.tipo,
    this.tipoDocumento,
    this.datos,
    this.url,
    this.pos,
    this.bodyValue,
    this.uri,
  });

  factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        titulo: json['titulo'].toString(),
        tipo: json['tipo'].toString(),
        tipoDocumento: json['tipo_documento'].toString(),
        datos: json['datos'].toString(),
        url: json['url'].toString(),
        pos: json['pos'].toString(),
        bodyValue: json['body_value'].toString(),
        uri: json['uri'].toString(),
      );

  String? titulo;
  String? tipo;
  String? tipoDocumento;
  String? datos;
  String? url;
  String? pos;
  String? bodyValue;
  String? uri;

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'tipo': tipo,
        'tipo_documento': tipoDocumento,
        'datos': datos,
        'url': url,
        'pos': pos,
        'body_value': bodyValue,
        'uri': uri,
      };
}
