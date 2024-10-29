// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Evaluacion welcomeFromJson(String str) =>
    Evaluacion.fromJson(json.decode(str) as Map<String, dynamic>);

String welcomeToJson(Evaluacion data) => json.encode(data.toJson());

class Evaluacion {
  Evaluacion({
    this.status,
  });

  factory Evaluacion.fromJson(Map<String, dynamic> json) => Evaluacion(
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
    this.evaluaciones,
  });

  factory Status.fromJson(dynamic json) => Status(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        evaluaciones: List<EvaluacionItem>.from(
          json['evaluaciones'].map(
            EvaluacionItem.fromJson,
          ) as Iterable<dynamic>,
        ),
      );

  String? type;
  int? code;
  String? message;
  List<EvaluacionItem>? evaluaciones;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'evaluaciones':
            List<dynamic>.from(evaluaciones!.map((x) => x.toJson())),
      };
}

class EvaluacionItem {
  EvaluacionItem({
    this.nid,
    this.title,
    this.portada,
    this.tiempo,
    this.descripcion,
    this.porcentaje,
    this.puntaje,
    this.sustitutorio,
  });

  factory EvaluacionItem.fromJson(dynamic json) => EvaluacionItem(
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        portada: json['portada'].toString(),
        tiempo: json['tiempo'].toString(),
        descripcion: json['descripcion'].toString(),
        porcentaje: int.parse(json['porcentaje'].toString()),
        puntaje: json['puntaje'],
        sustitutorio: json['sustitutorio'],
      );

  String? nid;
  String? title;
  String? portada;
  String? tiempo;
  String? descripcion;
  int? porcentaje;
  dynamic puntaje;
  dynamic sustitutorio;

  Map<String, dynamic> toJson() => {
        'nid': nid,
        'title': title,
        'portada': portada,
        'tiempo': tiempo,
        'descripcion': descripcion,
        'porcentaje': porcentaje,
        'puntaje': puntaje,
        'sustitutorio': sustitutorio,
      };
}
