// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:convert';

JuegosModel juegosModelFromJson(String str) =>
    JuegosModel.fromJson(json.decode(str) as Map<String, dynamic>);

String juegosModelToJson(JuegosModel data) => json.encode(data.toJson());

class JuegosModel {
  JuegosModel({
    required this.response,
    required this.body,
  });

  factory JuegosModel.fromJson(Map<String, dynamic> json) => JuegosModel(
        response: Response.fromJson(json['response'] as Map<String, dynamic>),
        body: List<Body>.from(
          json['body'].map((x) => Body.fromJson(x as Map<String, dynamic>))
              as Iterable,
        ),
      );
  Response? response;
  List<Body>? body;

  Map<String, dynamic> toJson() => {
        'response': response!.toJson(),
        'body': List<dynamic>.from(body!.map((x) => x.toJson())),
      };
}

class Body {
  Body({
    required this.nid,
    required this.title,
    required this.created,
    required this.content,
    required this.image,
    required this.status,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        created: json['created'].toString(),
        content: json['content'].toString(),
        image: json['image'].toString(),
        status: int.parse(json['status'].toString()),
      );
  String? nid;
  String? title;
  String? created;
  String? content;
  String? image;
  int? status;

  Map<String, dynamic> toJson() => {
        'nid': nid,
        'title': title,
        'created': created,
        'content': content,
        'image': image,
        'status': status,
      };
}

class Response {
  Response({
    required this.type,
    required this.code,
    required this.message,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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
