// To parse this JSON data, do
//
//     final activeTestSalida = activeTestSalidaFromJson(jsonString);

import 'dart:convert';

ActiveTestSalida activeTestSalidaFromJson(String str) =>
    ActiveTestSalida.fromJson(json.decode(str) as Map<String, dynamic>);

String activeTestSalidaToJson(ActiveTestSalida data) =>
    json.encode(data.toJson());

class ActiveTestSalida {
  ActiveTestSalida({
    this.status,
  });

  factory ActiveTestSalida.fromJson(Map<String, dynamic> json) =>
      ActiveTestSalida(
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
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
      );

  String? type;
  int? code;
  String? message;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
      };
}
