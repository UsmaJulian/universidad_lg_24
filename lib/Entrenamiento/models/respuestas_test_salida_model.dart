// To parse this JSON data, do
//
//     final respuestasTestSalida = respuestasTestSalidaFromJson(jsonString);

import 'dart:convert';

RespuestasTestSalida respuestasTestSalidaFromJson(String str) =>
    RespuestasTestSalida.fromJson(json.decode(str) as Map<String, dynamic>);

String respuestasTestSalidaToJson(RespuestasTestSalida data) =>
    json.encode(data.toJson());

class RespuestasTestSalida {
  RespuestasTestSalida({
    this.status,
  });

  factory RespuestasTestSalida.fromJson(Map<String, dynamic> json) =>
      RespuestasTestSalida(
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
    this.respuetas,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
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

  factory Respuetas.fromJson(Map<String, dynamic> json) => Respuetas(
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
    this.itemClass,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'].toString(),
        pregunta: json['pregunta'].toString(),
        tipo: int.parse(json['tipo'].toString()),
        respuesta: List<Respuesta>.from(
          json['respuesta'].map(Respuesta.fromJson) as Iterable<Respuesta>,
        ),
        itemClass: json['class'].toString(),
      );

  String? id;
  String? pregunta;
  int? tipo;
  List<Respuesta>? respuesta;
  String? itemClass;

  Map<String, dynamic> toJson() => {
        'id': id,
        'pregunta': pregunta,
        'tipo': tipo,
        'respuesta': List<dynamic>.from(respuesta!.map((x) => x.toJson())),
        'class': itemClass,
      };
}

class Respuesta {
  Respuesta({
    this.respuesta,
    this.estado,
  });

  factory Respuesta.fromJson(Map<String, dynamic> json) => Respuesta(
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
