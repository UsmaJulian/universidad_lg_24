// To parse this JSON data, do
//
//     final resuelveloTestModel = resuelveloTestModelFromJson(jsonString);

// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:convert';

ResuelveloTestModel resuelveloTestModelFromJson(String str) =>
    ResuelveloTestModel.fromJson(json.decode(str) as Map<String, dynamic>);

String resuelveloTestModelToJson(ResuelveloTestModel data) =>
    json.encode(data.toJson());

class ResuelveloTestModel {
  ResuelveloTestModel({
    required this.response,
    required this.body,
  });

  factory ResuelveloTestModel.fromJson(Map<String, dynamic> json) =>
      ResuelveloTestModel(
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
    required this.nid,
    required this.title,
    required this.created,
    required this.test,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        created: json['created'].toString(),
        test: List<Test>.from(
          json['test'].map((x) => Test.fromJson(x as Map<String, dynamic>))
              as Iterable,
        ),
      );
  String nid;
  String title;
  String created;
  List<Test> test;

  Map<String, dynamic> toJson() => {
        'nid': nid,
        'title': title,
        'created': created,
        'test': List<dynamic>.from(test.map((x) => x.toJson())),
      };
}

class Test {
  Test({
    required this.question,
    required this.anwers,
  });

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        question: json['question'].toString(),
        anwers: List<String>.from(json['anwers'].map((x) => x) as Iterable),
      );
  String question;
  List<String> anwers;

  Map<String, dynamic> toJson() => {
        'question': question,
        'anwers': List<dynamic>.from(anwers.map((x) => x)),
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
