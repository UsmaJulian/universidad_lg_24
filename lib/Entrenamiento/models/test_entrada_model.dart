// To parse this JSON data, do
//
//     final testEntrada = testEntradaFromJson(jsonString);

import 'dart:convert';

TestEntrada testEntradaFromJson(String str) =>
    TestEntrada.fromJson(json.decode(str) as Map<String, dynamic>);

String testEntradaToJson(TestEntrada data) => json.encode(data.toJson());

class TestEntrada {
  TestEntrada({
    this.status,
  });

  factory TestEntrada.fromJson(Map<String, dynamic> json) => TestEntrada(
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
    this.tiempo,
    this.preguntas,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        tiempo: json['tiempo'].toString(),
        preguntas: List<Pregunta>.from(
          json['preguntas'].map(Pregunta.fromJson) as Iterable<Pregunta>,
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

  factory Pregunta.fromJson(Map<String, dynamic> json) => Pregunta(
        id: json['id'].toString(),
        texto: json['texto'].toString(),
        correcta: json['correcta'].toString(),
        tipo: int.parse(json['tipo'].toString()),
        respuestas: List<Respuesta>.from(
          json['respuestas'].map(Respuesta.fromJson) as Iterable<Respuesta>,
        ),
      );

  String? id;
  String? texto;
  String? correcta;
  int? tipo;
  List<Respuesta>? respuestas;

  Map<String, dynamic> toJson() => {
        'id': id,
        'texto': texto,
        'correcta': correcta,
        'tipo': tipo,
        'respuestas': List<dynamic>.from(respuestas!.map((x) => x.toJson())),
      };
}

class Respuesta {
  Respuesta({
    this.delta,
    this.texto,
  });

  factory Respuesta.fromJson(Map<String, dynamic> json) => Respuesta(
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
