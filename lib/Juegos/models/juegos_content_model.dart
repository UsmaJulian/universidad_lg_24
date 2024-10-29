// To parse this JSON data, do
//
//     final juegosContent = juegosContentFromJson(jsonString);

// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:convert';

JuegosContent juegosContentFromJson(String str) =>
    JuegosContent.fromJson(json.decode(str) as Map<String, dynamic>);

String juegosContentToJson(JuegosContent data) => json.encode(data.toJson());

class JuegosContent {
  JuegosContent({
    required this.response,
    required this.body,
  });

  factory JuegosContent.fromJson(Map<String, dynamic> json) => JuegosContent(
        response: Response.fromJson(json['response'] as Map<String, dynamic>),
        body: Body.fromJson(json['body'] as Map<String, dynamic>),
      );
  Response? response;
  Body? body;

  Map<String, dynamic> toJson() => {
        'response': response!.toJson(),
        'body': body!.toJson(),
      };
}

class Body {
  Body({
    required this.nid,
    required this.title,
    required this.created,
    required this.content,
    required this.image,
    required this.trivia,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        created: json['created'].toString(),
        content: json['content'].toString(),
        image: json['image'].toString(),
        trivia: List<Trivia>.from(
          json['trivia'].map((x) => Trivia.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>,
        ),
      );
  String? nid;
  String? title;
  String? created;
  String? content;
  String? image;
  List<Trivia>? trivia;

  Map<String, dynamic> toJson() => {
        'nid': nid,
        'title': title,
        'created': created,
        'content': content,
        'image': image,
        'trivia': List<dynamic>.from(trivia!.map((x) => x.toJson())),
      };
}

class Trivia {
  Trivia({
    required this.question,
    required this.anwers,
  });

  factory Trivia.fromJson(Map<String, dynamic> json) => Trivia(
        question: json['question'].toString(),
        anwers: List<String>.from(json['anwers'].map((x) => x) as Iterable),
      );
  String? question;
  List<String>? anwers;

  Map<String, dynamic> toJson() => {
        'question': question,
        'anwers': List<dynamic>.from(anwers!.map((x) => x)),
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
