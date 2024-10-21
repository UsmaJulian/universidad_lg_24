// To parse this JSON data, do
//
//     final reelsModel = reelsModelFromJson(jsonString);

// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

import 'dart:convert';

ReelsModel reelsModelFromJson(String str) =>
    ReelsModel.fromJson(json.decode(str) as Map<String, dynamic>);

String reelsModelToJson(ReelsModel data) => json.encode(data.toJson());

class ReelsModel {
  ReelsModel({
    required this.response,
    required this.body,
  });

  factory ReelsModel.fromJson(Map<String, dynamic> json) => ReelsModel(
        response: Response.fromJson(json['response'] as Map<String, dynamic>),
        body: List<Body>.from(
          json['body'].map((x) => Body.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>,
        ),
      );
  Response response;
  List<Body> body;

  Map<String, dynamic> toJson() => {
        'response': response.toJson(),
        'body': List<dynamic>.from(body.map((x) => x.toJson())),
      };
}

class Body {
  Body({
    required this.resource,
    required this.thumbnail,
    required this.nid,
    required this.title,
    required this.type,
    required this.created,
    required this.content,
    required this.tags,
    required this.likes,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        resource: json['resource'].toString(),
        thumbnail: json['thumbnail'].toString(),
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        type: json['type'].toString(),
        created: json['created'].toString(),
        content: json['content'].toString(),
        tags:
            List<String>.from(json['tags'].map((x) => x) as Iterable<dynamic>),
        likes: int.parse(json['likes'].toString()),
      );
  String resource;
  String thumbnail;
  String nid;
  String title;
  String type;
  String created;
  String content;
  List<String> tags;
  int likes;

  Map<String, dynamic> toJson() => {
        'resource': resource,
        'thumbnail': thumbnail,
        'nid': nid,
        'title': title,
        'created': created,
        'content': content,
        'tags': List<dynamic>.from(tags.map((x) => x)),
        'likes': likes,
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
  String type;
  int code;
  String message;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
      };
}
