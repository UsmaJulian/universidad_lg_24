// To parse this JSON data, do
//
//     final noticias = noticiasFromJson(jsonString);

import 'dart:convert';

Noticias noticiasFromJson(String str) =>
    Noticias.fromJson(json.decode(str) as Map<String, dynamic>);

String noticiasToJson(Noticias data) => json.encode(data.toJson());

class Noticias {
  Noticias({
    required this.status,
  });

  factory Noticias.fromJson(Map<String, dynamic> json) => Noticias(
        status: Status.fromJson(json['status'] as Map<String, dynamic>),
      );

  Status status;

  Map<String, dynamic> toJson() => {
        'status': status.toJson(),
      };
}

class Status {
  Status({
    required this.type,
    required this.code,
    required this.message,
    required this.data,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        data: List<Datum>.from(
          json['data'].map(Datum.fromJson) as Iterable<Datum>,
        ),
      );

  String type;
  int code;
  String message;
  List<Datum> data;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.nid,
    required this.title,
    required this.created,
    required this.uri,
    required this.bodyValue,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        created: json['created'].toString(),
        uri: json['uri'].toString(),
        bodyValue: json['body_value'].toString(),
      );

  String nid;
  String title;
  String created;
  String uri;
  String bodyValue;

  Map<String, dynamic> toJson() => {
        'nid': nid,
        'title': title,
        'created': created,
        'uri': uri,
        'body_value': bodyValue,
      };
}
