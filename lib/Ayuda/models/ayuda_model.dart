// To parse this JSON data, do
//
//     final ayuda = ayudaFromJson(jsonString);

import 'dart:convert';

Ayuda ayudaFromJson(String str) =>
    Ayuda.fromJson(json.decode(str) as Map<String, dynamic>);

String ayudaToJson(Ayuda data) => json.encode(data.toJson());

class Ayuda {
  Ayuda({
    this.status,
  });

  factory Ayuda.fromJson(Map<String, dynamic> json) => Ayuda(
        status: Status.fromJson(json['status'] as Map<String, dynamic>),
      );

  Status? status;

  Map<String, dynamic> toJson() => {
        'status': status!.toJson(),
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
        data: List<Datum>.from(
          json['data'].map(Datum.fromJson) as Iterable,
        ),
      );

  String? type;
  int? code;
  String? message;
  List<Datum>? data;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.title,
    this.bodyValue,
    this.isExpanded,
  });

  factory Datum.fromJson(dynamic json) => Datum(
        title: json['title'].toString(),
        bodyValue: json['body_value'].toString(),
        isExpanded: false,
      );

  String? title;
  String? bodyValue;
  bool? isExpanded;

  Map<String, dynamic> toJson() => {
        'title': title,
        'body_value': bodyValue,
      };
}
