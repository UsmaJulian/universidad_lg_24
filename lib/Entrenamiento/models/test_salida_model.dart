// To parse this JSON data, do
//
//     final testSalida = testSalidaFromJson(jsonString);

import 'dart:convert';

TestSalida testSalidaFromJson(String str) =>
    TestSalida.fromJson(json.decode(str) as Map<String, dynamic>);

String testSalidaToJson(TestSalida data) => json.encode(data.toJson());

class TestSalida {
  TestSalida({
    this.status,
  });

  factory TestSalida.fromJson(Map<String, dynamic> json) => TestSalida(
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
    this.encuestas,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        tiempo: json['tiempo'].toString(),
        preguntas: List<StatusPregunta>.from(
          json['preguntas'].map(StatusPregunta.fromJson)
              as Iterable<StatusPregunta>,
        ),
      );

  String? type;
  int? code;
  String? message;
  String? tiempo;
  List<StatusPregunta>? preguntas;
  Encuestas? encuestas;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'tiempo': tiempo,
        'preguntas': List<dynamic>.from(preguntas!.map((x) => x.toJson())),
        'encuestas': encuestas?.toJson(),
      };
}

class Encuestas {
  Encuestas({
    this.titulo,
    this.preguntas,
  });

  factory Encuestas.fromJson(Map<String, dynamic> json) => Encuestas(
        titulo: json['titulo'].toString(),
        preguntas: List<EncuestasPregunta>.from(
          json['preguntas'].map(EncuestasPregunta.fromJson) as Iterable,
        ),
      );

  String? titulo;
  List<EncuestasPregunta>? preguntas;

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'preguntas': List<dynamic>.from(preguntas!.map((x) => x.toJson())),
      };
}

class EncuestasPregunta {
  EncuestasPregunta({
    this.tipo,
    this.idPregunta,
    this.pregunta,
    this.respuesta,
  });

  factory EncuestasPregunta.fromJson(Map<String, dynamic> json) =>
      EncuestasPregunta(
        tipo: json['tipo'].toString(),
        idPregunta: json['id_pregunta'].toString(),
        pregunta: json['pregunta'].toString(),
        respuesta: json['respuesta'] == null
            ? null
            : List<String>.from(
                json['respuesta'].map((x) => x.toString()) as Iterable,
              ),
      );

  String? tipo;
  String? idPregunta;
  String? pregunta;
  List<String>? respuesta;

  Map<String, dynamic> toJson() => {
        'tipo': tipo,
        'id_pregunta': idPregunta,
        'pregunta': pregunta,
        'respuesta': respuesta == null
            ? null
            : List<dynamic>.from(respuesta!.map((x) => x)),
      };
}

class StatusPregunta {
  StatusPregunta({
    this.id,
    this.texto,
    this.correcta,
    this.tipo,
    this.respuestas,
  });

  factory StatusPregunta.fromJson(Map<String, dynamic> json) => StatusPregunta(
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
