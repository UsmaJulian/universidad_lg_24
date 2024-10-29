// To parse this JSON data, do
//
//     final cursoPreview = cursoPreviewFromJson(jsonString);

import 'dart:convert';

CursoPreview cursoPreviewFromJson(String str) =>
    CursoPreview.fromJson(json.decode(str) as Map<String, dynamic>);

String cursoPreviewToJson(CursoPreview data) => json.encode(data.toJson());

class CursoPreview {
  CursoPreview({
    this.status,
  });

  factory CursoPreview.fromJson(Map<String, dynamic> json) => CursoPreview(
        status: StatusPreview.fromJson(json['status'] as Map<String, dynamic>),
      );

  StatusPreview? status;

  Map<String, dynamic> toJson() => {
        'status': status?.toJson(),
      };
}

class StatusPreview {
  StatusPreview({
    this.type,
    this.code,
    this.message,
    this.data,
  });

  factory StatusPreview.fromJson(Map<String, dynamic> json) => StatusPreview(
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
    this.leccionId,
    this.testEntrada,
    this.testTiempo,
    this.sustitutorio,
    this.puntaje,
    this.testSalida,
    this.verCurso,
  });

  factory Data.fromJson(dynamic json) => Data(
        curso: Curso.fromJson(json!['curso']),
        leccionId: json['leccion_id'].toString(),
        testEntrada: int.parse(json['test_entrada'].toString()),
        testTiempo: json['test_tiempo'].toString(),
        sustitutorio: int.parse(json['sustitutorio'].toString()),
        puntaje: int.parse(json['puntaje'].toString()),
        testSalida: int.parse(json['test_salida'].toString()),
        verCurso: int.parse(json['ver_curso'].toString()),
      );

  Curso? curso;
  String? leccionId;
  int? testEntrada;
  String? testTiempo;
  int? sustitutorio;
  int? puntaje;
  int? testSalida;
  int? verCurso;

  Map<String, dynamic> toJson() => {
        'curso': curso?.toJson(),
        'leccion_id': leccionId,
        'test_entrada': testEntrada,
        'test_tiempo': testTiempo,
        'sustitutorio': sustitutorio,
        'puntaje': puntaje,
        'test_salida': testSalida,
        'ver_curso': verCurso,
      };
}

class Curso {
  Curso({
    this.nid,
    this.title,
    this.uri,
    this.bodyValue,
    this.video,
  });

  factory Curso.fromJson(dynamic json) => Curso(
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        uri: json['uri'].toString(),
        bodyValue: json['body_value'].toString(),
        video: json['video'].toString(),
      );

  String? nid;
  String? title;
  String? uri;
  String? bodyValue;
  String? video;

  Map<String, dynamic> toJson() => {
        'nid': nid,
        'title': title,
        'uri': uri,
        'body_value': bodyValue,
        'video': video,
      };
}
