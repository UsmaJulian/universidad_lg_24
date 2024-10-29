// To parse this JSON data, do
//
//     final reelsLikesModel = reelsLikesModelFromJson(jsonString);

import 'dart:convert';

ReelsLikesModel reelsLikesModelFromJson(String str) =>
    ReelsLikesModel.fromJson(json.decode(str) as Map<String, dynamic>);

String reelsLikesModelToJson(ReelsLikesModel data) =>
    json.encode(data.toJson());

class ReelsLikesModel {
  ReelsLikesModel({
    required this.response,
    required this.body,
  });

  factory ReelsLikesModel.fromJson(Map<String, dynamic> json) =>
      ReelsLikesModel(
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
    required this.idReel,
    required this.likes,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        idReel: json['id_reel'].toString(),
        likes: int.parse(json['likes'].toString()),
      );
  String idReel;
  int likes;

  Map<String, dynamic> toJson() => {
        'id_reel': idReel,
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
