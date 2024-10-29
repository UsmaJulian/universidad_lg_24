// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SingleEvaluacion welcomeFromJsonSingle(String str) =>
    SingleEvaluacion.fromJson(json.decode(str) as Map<String, dynamic>);

String welcomeToJsonSingle(SingleEvaluacion data) => json.encode(data.toJson());

class SingleEvaluacion {
  SingleEvaluacion({
    this.status,
  });

  factory SingleEvaluacion.fromJson(Map<String, dynamic> json) =>
      SingleEvaluacion(
        status: StatusSingle.fromJson(json['status'] as Map<String, dynamic>),
      );

  StatusSingle? status;

  Map<String, dynamic> toJson() => {
        'status': status?.toJson(),
      };
}

class StatusSingle {
  StatusSingle({
    this.type,
    this.code,
    this.message,
    this.tiempo,
    this.preguntas,
  });

  factory StatusSingle.fromJson(Map<String, dynamic> json) => StatusSingle(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        tiempo: json['tiempo'].toString(),
        preguntas: List<Pregunta>.from(
          json['preguntas'].map(Pregunta.fromJson) as Iterable<dynamic>,
        ),
      );

  String? type;
  int? code;
  String? message;
  String? tiempo;
  List<Pregunta>? preguntas;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'tiempo': tiempo,
        'preguntas': List<dynamic>.from(preguntas!.map((x) => x.toJson())),
      };
}

class Pregunta {
  Pregunta({
    this.id,
    this.texto,
    this.correcta,
    this.tipo,
    this.respuestas,
  });

  factory Pregunta.fromJson(dynamic json) => Pregunta(
        id: json['id'].toString(),
        texto: json['texto'].toString(),
        correcta: int.parse(json['correcta'].toString()),
        tipo: int.parse(json['tipo'].toString()),
        respuestas: List<RespuestaSingle>.from(
          json['respuestas'].map(RespuestaSingle.fromJson) as Iterable<dynamic>,
        ),
      );

  String? id;
  String? texto;
  int? correcta;
  int? tipo;
  List<RespuestaSingle>? respuestas;

  Map<String, dynamic> toJson() => {
        'id': id,
        'texto': texto,
        'correcta': correcta,
        'tipo': tipo,
        'respuestas': List<dynamic>.from(respuestas!.map((x) => x.toJson())),
      };
}

class RespuestaSingle {
  RespuestaSingle({
    this.delta,
    this.texto,
  });

  factory RespuestaSingle.fromJson(dynamic json) => RespuestaSingle(
        delta: int.parse(json['delta'].toString()),
        texto: json['texto'].toString(),
      );

  int? delta;
  String? texto;

  Map<String, dynamic> toJson() => {
        'delta': delta,
        'texto': texto,
      };
}
