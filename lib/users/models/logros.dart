// To parse this JSON data, do
//
//     final logros = logrosFromJson(jsonString);

import 'dart:convert';

Logros logrosFromJson(String str) =>
    Logros.fromJson(json.decode(str) as Map<String, dynamic>);

String logrosToJson(Logros data) => json.encode(data.toJson());

class Logros {
  Logros({
    this.status,
  });

  factory Logros.fromJson(Map<String, dynamic> json) => Logros(
        status: StatusLogros.fromJson(json['status'] as Map<String, dynamic>),
      );

  StatusLogros? status;

  Map<String, dynamic> toJson() => {
        'status': status?.toJson(),
      };
}

class StatusLogros {
  StatusLogros({
    this.type,
    this.code,
    this.message,
    this.data,
  });

  factory StatusLogros.fromJson(Map<String, dynamic> json) => StatusLogros(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        data: List<DatumLogros>.from(
          json['data'].map(DatumLogros.fromJson) as Iterable,
        ),
      );

  String? type;
  int? code;
  String? message;
  List<DatumLogros>? data;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DatumLogros {
  DatumLogros({
    this.uid,
    this.nid,
    this.titulo,
    this.cuerpo,
    this.porcentaje,
    this.medalla,
  });

  factory DatumLogros.fromJson(dynamic json) => DatumLogros(
        uid: json['uid'].toString(),
        nid: json['nid'].toString(),
        titulo: json['titulo'].toString(),
        cuerpo: json['cuerpo'].toString(),
        porcentaje: json['porcentaje'].toString(),
        medalla: json['medalla'].toString(),
      );

  String? uid;
  String? nid;
  String? titulo;
  String? cuerpo;
  String? porcentaje;
  String? medalla;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'nid': nid,
        'titulo': titulo,
        'cuerpo': cuerpo,
        'porcentaje': porcentaje,
        'medalla': medalla,
      };
}
