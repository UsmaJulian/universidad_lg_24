// To parse this JSON data, do
//
//     final respuestaEvaluacion = respuestaEvaluacionFromJson(jsonString);

import 'dart:convert';

RespuestaEvaluacion respuestaEvaluacionFromJson(String str) =>
    RespuestaEvaluacion.fromJson(json.decode(str) as Map<String, dynamic>);

String respuestaEvaluacionToJson(RespuestaEvaluacion data) =>
    json.encode(data.toJson());

class RespuestaEvaluacion {
  RespuestaEvaluacion({
    this.status,
  });

  factory RespuestaEvaluacion.fromJson(dynamic json) => RespuestaEvaluacion(
        status: StatusResp.fromJson(json['status'] as Map<String, dynamic>),
      );

  StatusResp? status;

  Map<String, dynamic> toJson() => {
        'status': status?.toJson(),
      };
}

class StatusResp {
  StatusResp({
    this.type,
    this.code,
    this.message,
    this.respuetas,
  });

  factory StatusResp.fromJson(dynamic json) => StatusResp(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        respuetas:
            Respuetas.fromJson(json['respuetas'] as Map<String, dynamic>),
      );

  String? type;
  int? code;
  String? message;
  Respuetas? respuetas;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'respuetas': respuetas?.toJson(),
      };
}

class Respuetas {
  Respuetas({
    this.idCurso,
    this.items,
    this.inCorrectas,
  });

  factory Respuetas.fromJson(dynamic json) => Respuetas(
        idCurso: json['id_curso'].toString(),
        items: List<Item>.from(json['items'].map(Item.fromJson) as Iterable),
        inCorrectas: int.parse(json['inCorrectas'].toString()),
      );

  String? idCurso;
  List<Item>? items;
  int? inCorrectas;

  Map<String, dynamic> toJson() => {
        'id_curso': idCurso,
        'items': List<dynamic>.from(items!.map((x) => x.toJson())),
        'inCorrectas': inCorrectas,
      };
}

class Item {
  Item({
    this.id,
    this.pregunta,
    this.tipo,
    this.respuesta,
  });

  factory Item.fromJson(dynamic json) => Item(
        id: json['id'].toString(),
        pregunta: json['pregunta'].toString(),
        tipo: int.parse(json['tipo'].toString()),
        respuesta: List<Respuesta>.from(
          json['respuesta'].map(Respuesta.fromJson) as Iterable,
        ),
      );

  String? id;
  String? pregunta;
  int? tipo;
  List<Respuesta>? respuesta;

  Map<String, dynamic> toJson() => {
        'id': id,
        'pregunta': pregunta,
        'tipo': tipo,
        'respuesta': List<dynamic>.from(respuesta!.map((x) => x.toJson())),
      };
}

class Respuesta {
  Respuesta({
    this.respuesta,
    this.estado,
  });

  factory Respuesta.fromJson(dynamic json) => Respuesta(
        respuesta: json['respuesta'].toString(),
        estado: int.parse(json['estado'].toString()),
      );

  String? respuesta;
  int? estado;

  Map<String, dynamic> toJson() => {
        'respuesta': respuesta,
        'estado': estado,
      };
}
