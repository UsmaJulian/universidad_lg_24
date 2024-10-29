// To parse this JSON data, do
//
//     final sendTestEntrada = sendTestEntradaFromJson(jsonString);

import 'dart:convert';

SendTestEntrada sendTestEntradaFromJson(String str) =>
    SendTestEntrada.fromJson(json.decode(str) as Map<String, dynamic>);

String sendTestEntradaToJson(SendTestEntrada data) =>
    json.encode(data.toJson());

class SendTestEntrada {
  SendTestEntrada({
    this.status,
  });

  factory SendTestEntrada.fromJson(Map<String, dynamic> json) =>
      SendTestEntrada(
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
    this.dataTest,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        dataTest: DataTest.fromJson(json['dataTest'] as Map<String, dynamic>),
      );

  String? type;
  int? code;
  String? message;
  DataTest? dataTest;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'dataTest': dataTest?.toJson(),
      };
}

class DataTest {
  DataTest({
    this.copa,
    this.puntaje,
    this.titulo,
    this.nombre,
  });

  factory DataTest.fromJson(Map<String, dynamic> json) => DataTest(
        copa: json['copa'].toString(),
        puntaje: int.parse(json['puntaje'].toString()),
        titulo: json['titulo'].toString(),
        nombre: json['nombre'].toString(),
      );

  String? copa;
  int? puntaje;
  String? titulo;
  String? nombre;

  Map<String, dynamic> toJson() => {
        'copa': copa,
        'puntaje': puntaje,
        'titulo': titulo,
        'nombre': nombre,
      };
}
