// To parse this JSON data, do
//
//     final singleNoticia = singleNoticiaFromJson(jsonString);

import 'dart:convert';

SingleNoticia singleNoticiaFromJson(String str) =>
    SingleNoticia.fromJson(json.decode(str) as Map<String, dynamic>);

String singleNoticiaToJson(SingleNoticia data) => json.encode(data.toJson());

class SingleNoticia {
  SingleNoticia({
    required this.status,
  });

  factory SingleNoticia.fromJson(Map<String, dynamic> json) => SingleNoticia(
        status: StatusSingle.fromJson(json['status'] as Map<String, dynamic>),
      );

  StatusSingle status;

  Map<String, dynamic> toJson() => {
        'status': status.toJson(),
      };
}

class StatusSingle {
  StatusSingle({
    required this.type,
    required this.code,
    required this.message,
    required this.data,
  });

  factory StatusSingle.fromJson(Map<String, dynamic> json) => StatusSingle(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        data: Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  String type;
  int code;
  String message;
  Data data;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'data': data.toJson(),
      };
}

class Data {
  Data({
    required this.nid,
    required this.title,
    required this.uri,
    required this.created,
    required this.body,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        uri: json['uri'].toString(),
        created: json['created'].toString(),
        body: json['body'].toString(),
      );

  String nid;
  String title;
  String uri;
  String created;
  String body;

  Map<String, dynamic> toJson() => {
        'nid': nid,
        'title': title,
        'uri': uri,
        'created': created,
        'body': body,
      };
}
