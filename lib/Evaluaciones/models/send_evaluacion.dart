// To parse this JSON data, do
//
//     final sendEvaluacion = sendEvaluacionFromJson(jsonString);

import 'dart:convert';

SendEvaluacion sendEvaluacionFromJson(String str) =>
    SendEvaluacion.fromJson(json.decode(str) as Map<String, dynamic>);

String sendEvaluacionToJson(SendEvaluacion data) => json.encode(data.toJson());

class SendEvaluacion {
  SendEvaluacion({
    this.status,
  });

  factory SendEvaluacion.fromJson(Map<String, dynamic> json) => SendEvaluacion(
        status: StatusSend.fromJson(json['status'] as Map<String, dynamic>),
      );

  StatusSend? status;

  Map<String, dynamic> toJson() => {
        'status': status?.toJson(),
      };
}

class StatusSend {
  StatusSend({
    this.type,
    this.code,
    this.message,
    this.evaluacionRest,
  });

  factory StatusSend.fromJson(Map<String, dynamic> json) => StatusSend(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        evaluacionRest: EvaluacionRest.fromJson(
          json['evaluacionRest'] as Map<String, dynamic>,
        ),
      );

  String? type;
  int? code;
  String? message;
  EvaluacionRest? evaluacionRest;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'evaluacionRest': evaluacionRest?.toJson(),
      };
}

class EvaluacionRest {
  EvaluacionRest({
    this.sustituto,
    this.copa,
    this.puntaje,
    this.titulo,
  });

  factory EvaluacionRest.fromJson(Map<String, dynamic> json) => EvaluacionRest(
        sustituto: int.parse(json['sustituto'].toString()),
        copa: json['copa'].toString(),
        puntaje: int.parse(json['puntaje'].toString()),
        titulo: json['titulo'].toString(),
      );

  int? sustituto;
  String? copa;
  int? puntaje;
  String? titulo;

  Map<String, dynamic> toJson() => {
        'sustituto': sustituto,
        'copa': copa,
        'puntaje': puntaje,
        'titulo': titulo,
      };
}
