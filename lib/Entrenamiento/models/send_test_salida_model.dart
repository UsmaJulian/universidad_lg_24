// To parse this JSON data, do
//
//     final sendTestSalida = sendTestSalidaFromJson(jsonString);

import 'dart:convert';

SendTestSalida sendTestSalidaFromJson(String str) =>
    SendTestSalida.fromJson(json.decode(str) as Map<String, dynamic>);

String sendTestSalidaToJson(SendTestSalida data) => json.encode(data.toJson());

class SendTestSalida {
  SendTestSalida({
    this.status,
  });

  factory SendTestSalida.fromJson(Map<String, dynamic> json) => SendTestSalida(
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
    this.sustituto,
    this.copa,
    this.puntaje,
    this.titulo,
    this.nombre,
  });

  factory DataTest.fromJson(Map<String, dynamic> json) => DataTest(
        sustituto: int.parse(json['sustituto'].toString()),
        copa: json['copa'].toString(),
        puntaje: int.parse(json['puntaje'].toString()),
        titulo: json['titulo'].toString(),
        nombre: json['nombre'].toString(),
      );

  int? sustituto;
  String? copa;
  int? puntaje;
  String? titulo;
  String? nombre;

  Map<String, dynamic> toJson() => {
        'sustituto': sustituto,
        'copa': copa,
        'puntaje': puntaje,
        'titulo': titulo,
        'nombre': nombre,
      };
}
