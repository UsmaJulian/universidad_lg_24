import 'dart:convert';

HomeModel welcomeFromJson(String str) =>
    HomeModel.fromJson(json.decode(str) as Map<String, dynamic>);

String welcomeToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.status,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: Status.fromJson(
          json['status'] as Map<String, dynamic>,
        ),
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
    this.carrucel,
    this.noticias,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        carrucel: List<Carrucel>.from(
          json['carrucel'].map(Carrucel.fromJson) as Iterable<Carrucel>,
        ),
        noticias: List<Noticias>.from(
          json['noticias'].map(Noticias.fromJson) as Iterable<Noticias>,
        ),
      );

  String? type;
  int? code;
  String? message;
  List<Carrucel>? carrucel;
  List<Noticias>? noticias;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'carrucel': List<dynamic>.from(carrucel!.map((x) => x.toJson())),
        'noticias': List<dynamic>.from(noticias!.map((x) => x.toJson())),
      };
}

class Carrucel {
  Carrucel({
    this.imagen,
    this.nid,
    this.title,
    this.video,
    this.lead,
  });

  factory Carrucel.fromJson(Map<String, dynamic> json) => Carrucel(
        imagen: json['imagen'].toString(),
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        video: json['video'].toString(),
        lead: json['lead'].toString(),
      );

  String? imagen;
  String? nid;
  String? title;
  String? video;
  String? lead;

  Map<String, dynamic> toJson() => {
        'imagen': imagen,
        'nid': nid,
        'title': title,
        'video': video,
        'lead': lead,
      };
}

class Noticias {
  Noticias({
    this.imagen,
    this.nid,
    this.title,
    this.lead,
  });

  factory Noticias.fromJson(Map<String, dynamic> json) => Noticias(
        imagen: json['imagen'].toString(),
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        lead: json['lead'].toString(),
      );

  String? imagen;
  String? nid;
  String? title;
  String? video;
  String? lead;

  Map<String, dynamic> toJson() => {
        'imagen': imagen,
        'nid': nid,
        'title': title,
        'lead': lead,
      };
}
