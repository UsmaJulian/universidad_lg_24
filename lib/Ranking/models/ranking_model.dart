// To parse this JSON data, do
//
//     final ranking = rankingFromJson(jsonString);

import 'dart:convert';

Ranking rankingFromJson(String str) =>
    Ranking.fromJson(json.decode(str) as Map<String, dynamic>);

String rankingToJson(Ranking data) => json.encode(data.toJson());

class Ranking {
  Ranking({
    this.status,
  });

  factory Ranking.fromJson(Map<String, dynamic> json) => Ranking(
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
        data: List<dynamic>.from(
          json['data'].map(Datum.fromJson) as Iterable<dynamic>,
        ),
      );

  String? type;
  int? code;
  String? message;
  List<dynamic>? data;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.nombre,
    this.oro,
    this.plata,
    this.bronce,
    this.puntaje,
    this.totalMedallas,
    this.uri,
  });

  factory Datum.fromJson(dynamic json) => Datum(
        nombre: json['nombre'].toString(),
        oro: int.parse(json['oro'].toString()),
        plata: int.parse(json['plata'].toString()),
        bronce: int.parse(json['bronce'].toString()),
        puntaje: int.parse(json['puntaje'].toString()),
        totalMedallas: int.parse(json['total_medallas'].toString()),
        uri: json['uri'].toString(),
      );

  String? nombre;
  int? oro;
  int? plata;
  int? bronce;
  int? puntaje;
  int? totalMedallas;
  String? uri;

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'oro': oro,
        'plata': plata,
        'bronce': bronce,
        'puntaje': puntaje,
        'total_medallas': totalMedallas,
        'uri': uri,
      };
}
