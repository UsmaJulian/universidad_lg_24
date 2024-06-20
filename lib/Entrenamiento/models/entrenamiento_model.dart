// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

EntrenamientoModel welcomeFromJson(String str) =>
    EntrenamientoModel.fromJson(json.decode(str) as Map<String, dynamic>);

String welcomeToJson(EntrenamientoModel data) => json.encode(data.toJson());

class EntrenamientoModel {
  EntrenamientoModel({
    this.status,
  });

  factory EntrenamientoModel.fromJson(Map<String, dynamic> json) =>
      EntrenamientoModel(
        status: Status.fromJson(json['status'] as Map<String, dynamic>),
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
    this.cursos,
    this.filtros,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        cursos: Cursos.fromJson(json['cursos'] as Map<String, dynamic>),
        filtros: List<Filtro>.from(
          (json['filtros'] as List<dynamic>).map(
            (x) => Filtro.fromJson(x as Map<String, dynamic>),
          ),
        ),
      );

  String? type;
  int? code;
  String? message;
  Cursos? cursos;
  List<Filtro>? filtros;

  Map<String, dynamic> toJson() => {
        'type': type,
        'code': code,
        'message': message,
        'cursos': cursos?.toJson(),
        'filtros': List<dynamic>.from(filtros!.map((x) => x.toJson())),
      };
}

class Cursos {
  Cursos({
    this.avanzado,
    this.intermedio,
    this.basico,
  });

  factory Cursos.fromJson(Map<String, dynamic> json) => Cursos(
        avanzado: Map.from(json['avanzado'] as Map<dynamic, dynamic>).map(
          (k, v) => MapEntry<String, TipoCurso>(
            k.toString(),
            TipoCurso.fromJson(v as Map<String, dynamic>),
          ),
        ),
        intermedio: Map.from(json['intermedio'] as Map<dynamic, dynamic>).map(
          (k, v) => MapEntry<String, TipoCurso>(
            k.toString(),
            TipoCurso.fromJson(v as Map<String, dynamic>),
          ),
        ),
        basico: Map.from(json['basico'] as Map<dynamic, dynamic>).map(
          (k, v) => MapEntry<String, TipoCurso>(
            k.toString(),
            TipoCurso.fromJson(v as Map<String, dynamic>),
          ),
        ),
      );

  Map<String, TipoCurso>? avanzado;
  Map<String, TipoCurso>? intermedio;
  Map<String, TipoCurso>? basico;

  Map<String, dynamic> toJson() => {
        'avanzado': Map.from(avanzado!)
            .map((k, v) => MapEntry<String, dynamic>(k.toString(), v.toJson())),
        'intermedio': Map.from(intermedio!)
            .map((k, v) => MapEntry<String, dynamic>(k.toString(), v.toJson())),
        'basico': Map.from(basico!)
            .map((k, v) => MapEntry<String, dynamic>(k.toString(), v.toJson())),
      };
}

class TipoCurso {
  TipoCurso({
    this.nid,
    this.title,
    this.tipo,
    this.imagen,
    this.portada,
    this.porcentaje,
    this.categoria,
    this.body,
  });

  factory TipoCurso.fromJson(Map<String, dynamic> json) => TipoCurso(
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        tipo: json['tipo'].toString(),
        imagen: json['imagen'].toString(),
        portada: json['portada'].toString(),
        porcentaje: int.parse(json['porcentaje'].toString()),
        categoria: json['categoria'].toString(),
        body: json['body'].toString(),
      );

  String? nid;
  String? title;
  String? tipo;
  String? imagen;
  String? portada;
  int? porcentaje;
  String? categoria;
  String? body;

  Map<String, dynamic> toJson() => {
        'nid': nid,
        'title': title,
        'tipo': tipo,
        'imagen': imagen,
        'portada': portada,
        'porcentaje': porcentaje,
        'categoria': categoria,
        'body': body,
      };
}

class Filtro {
  Filtro({
    this.tid,
    this.name,
  });

  factory Filtro.fromJson(Map<String, dynamic> json) => Filtro(
        tid: json['tid'].toString(),
        name: json['name'].toString(),
      );

  String? tid;
  String? name;

  Map<String, dynamic> toJson() => {
        'tid': tid,
        'name': name,
      };
}
