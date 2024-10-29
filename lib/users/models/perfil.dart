// To parse this JSON data, do
//
//     final perfil = perfilFromJson(jsonString);

import 'dart:convert';

Perfil perfilFromJson(String str) =>
    Perfil.fromJson(json.decode(str) as Map<String, dynamic>);

String perfilToJson(Perfil data) => json.encode(data.toJson());

class Perfil {
  Perfil({
    this.status,
  });

  factory Perfil.fromJson(Map<String, dynamic> json) => Perfil(
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
    this.data,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        data: Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  String? type;
  int? code;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'data': data?.toJson(),
      };
}

class Data {
  Data({
    this.imagen,
    this.totalpuntos,
    this.oro,
    this.plata,
    this.bronce,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        imagen: json['imagen'].toString(),
        totalpuntos: int.parse(json['totalpuntos'].toString()),
        oro: int.parse(json['oro'].toString()),
        plata: int.parse(json['plata'].toString()),
        bronce: int.parse(json['bronce'].toString()),
      );

  String? imagen;
  int? totalpuntos;
  int? oro;
  int? plata;
  int? bronce;

  Map<String, dynamic> toJson() => {
        'imagen': imagen,
        'totalpuntos': totalpuntos,
        'oro': oro,
        'plata': plata,
        'bronce': bronce,
      };
}
