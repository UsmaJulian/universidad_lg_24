// To parse this JSON data, do
//
//     final newHomeModel = newHomeModelFromJson(jsonString);

import 'dart:convert';

NewHomeModel newHomeModelFromJson(String str) =>
    NewHomeModel.fromJson(json.decode(str) as Map<String, dynamic>);

String newHomeModelToJson(NewHomeModel data) => json.encode(data.toJson());

class NewHomeModel {
  NewHomeModel({
    required this.response,
    required this.body,
  });

  factory NewHomeModel.fromJson(Map<String, dynamic> json) => NewHomeModel(
        response: Response.fromJson(json['response'] as Map<String, dynamic>),
        body: Body.fromJson(json['body'] as Map<String, dynamic>),
      );
  Response? response;
  Body? body;

  Map<String, dynamic> toJson() => {
        'response': response?.toJson(),
        'body': body?.toJson(),
      };
}

class Body {
  Body({
    required this.slides,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        slides: List<Slide>.from(
          json['slides'].map(Slide.fromJson) as Iterable,
        ),
      );
  List<Slide>? slides;

  Map<String, dynamic> toJson() => {
        'slides': List<dynamic>.from(slides!.map((x) => x.toJson())),
      };
}

class Slide {
  Slide({
    required this.nid,
    required this.title,
    required this.imagenWeb,
    required this.linkWeb,
    required this.imagenApp,
    required this.linkApp,
  });

  factory Slide.fromJson(dynamic json) => Slide(
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        imagenWeb: json['imagenWeb'].toString(),
        linkWeb: json['linkWeb'].toString(),
        imagenApp: json['imagenApp'].toString(),
        linkApp: json['linkApp'].toString(),
      );
  String? nid;
  String? title;
  String? imagenWeb;
  String? linkWeb;
  String? imagenApp;
  String? linkApp;

  Map<String, dynamic> toJson() => {
        'nid': nid,
        'title': title,
        'imagenWeb': imagenWeb,
        'linkWeb': linkWeb,
        'imagenApp': imagenApp,
        'linkApp': linkApp,
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
