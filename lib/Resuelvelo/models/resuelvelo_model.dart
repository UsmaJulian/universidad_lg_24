// To parse this JSON data, do
//
//     final resuelveloModel = resuelveloModelFromJson(jsonString);

// ignore_for_file: inference_failure_on_untyped_parameter, avoid_dynamic_calls

import 'dart:convert';

ResuelveloModel resuelveloModelFromJson(String str) =>
    ResuelveloModel.fromJson(json.decode(str) as Map<String, dynamic>);

String resuelveloModelToJson(ResuelveloModel data) =>
    json.encode(data.toJson());

class ResuelveloModel {
  ResuelveloModel({
    required this.response,
    required this.body,
  });

  factory ResuelveloModel.fromJson(Map<String, dynamic> json) =>
      ResuelveloModel(
        response: Response.fromJson(json['response'] as Map<String, dynamic>),
        body: Body.fromJson(json['body'] as Map<String, dynamic>),
      );
  Response response;
  Body body;

  Map<String, dynamic> toJson() => {
        'response': response.toJson(),
        'body': body.toJson(),
      };
}

class Body {
  Body({
    required this.info,
    required this.data,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        info: Info.fromJson(json['info'] as Map<String, dynamic>),
        data: List<Datum>.from(
          json['data'].map((x) => Datum.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>,
        ),
      );
  Info info;
  List<Datum> data;

  Map<String, dynamic> toJson() => {
        'info': info.toJson(),
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.resource,
    required this.thumbnail,
    required this.nid,
    required this.title,
    required this.created,
    required this.content,
    required this.tags,
    required this.likes,
    required this.comments,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        resource: json['resource'].toString(),
        thumbnail: json['thumbnail'].toString(),
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        created: json['created'].toString(),
        content: json['content'].toString(),
        tags:
            List<String>.from(json['tags'].map((x) => x) as Iterable<dynamic>),
        likes: int.parse(json['likes'].toString()),
        comments: List<Comment>.from(
          json['comments']
                  .map((x) => Comment.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>,
        ),
      );
  String resource;
  String thumbnail;
  String nid;
  String title;
  String created;
  String content;
  List<String> tags;
  int likes;
  List<Comment> comments;

  Map<String, dynamic> toJson() => {
        'resource': resource,
        'thumbnail': thumbnail,
        'nid': nid,
        'title': title,
        'created': created,
        'content': content,
        'tags': List<dynamic>.from(tags.map((x) => x)),
        'likes': likes,
        'comments': List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    required this.user,
    required this.avatar,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user: json['user'].toString(),
        avatar: json['avatar'].toString(),
        comment: json['comment'].toString(),
      );
  String user;
  String avatar;
  String comment;

  Map<String, dynamic> toJson() => {
        'user': user,
        'avatar': avatar,
        'comment': comment,
      };
}

class Info {
  Info({
    required this.banner,
    required this.content,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        banner: json['banner'].toString(),
        content: json['content'].toString(),
      );
  String banner;
  String content;

  Map<String, dynamic> toJson() => {
        'banner': banner,
        'content': content,
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
