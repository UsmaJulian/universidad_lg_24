// To parse this JSON data, do
//
//     final biblioteca = bibliotecaFromMap(jsonString);

import 'dart:convert';

Biblioteca bibliotecaFromMap(String str) =>
    Biblioteca.fromMap(json.decode(str) as dynamic);

String bibliotecaToMap(Biblioteca data) => json.encode(data.toMap());

class Biblioteca {
  Biblioteca({
    this.status,
  });

  factory Biblioteca.fromMap(dynamic json) => Biblioteca(
        status: json['status'] == null
            ? null
            : Status.fromMap(json['status'] as dynamic),
      );
  final Status? status;

  dynamic toMap() => {
        'status': status?.toMap(),
      };
}

class Status {
  Status({
    this.type,
    this.code,
    this.message,
    this.data,
  });

  factory Status.fromMap(dynamic json) => Status(
        type: json['type'].toString(),
        code: int.parse(json['code'].toString()),
        message: json['message'].toString(),
        data:
            json['data'] == null ? null : Data.fromMap(json['data'] as dynamic),
      );
  final String? type;
  final int? code;
  final String? message;
  final Data? data;

  dynamic toMap() => {
        'type': type,
        'code': code,
        'message': message,
        'data': data?.toMap(),
      };
}

class Data {
  Data({
    this.filtros,
    this.filtrosCate,
    this.biblioteca,
  });

  factory Data.fromMap(dynamic json) => Data(
        filtros: json['filtros'] == null
            ? []
            : List<Filtro>.from(
                json['filtros']!.map(Filtro.fromMap) as Iterable<dynamic>,
              ),
        filtrosCate: json['filtros_cate'] == null
            ? []
            : List<FiltrosCate>.from(
                json['filtros_cate']!.map(FiltrosCate.fromMap)
                    as Iterable<dynamic>,
              ),
        biblioteca: json['biblioteca'] == null
            ? null
            : Map.from(json['biblioteca'] as Map).map(
                (k, v) => MapEntry<String, BibliotecaValue>(
                  k.toString(),
                  BibliotecaValue.fromMap(v as dynamic),
                ),
              ),
      );
  final List<Filtro>? filtros;
  final List<FiltrosCate>? filtrosCate;
  final Map<String, BibliotecaValue>? biblioteca;

  dynamic toMap() => {
        'filtros': filtros == null
            ? []
            : List<dynamic>.from(filtros!.map((x) => x.toMap())),
        'filtros_cate': filtrosCate == null
            ? []
            : List<dynamic>.from(filtrosCate!.map((x) => x.toMap())),
        'biblioteca': Map.from(biblioteca!)
            .map((k, v) => MapEntry<String, dynamic>(k.toString(), v.toMap())),
      };
}

class BibliotecaValue {
  BibliotecaValue({
    this.nid,
    this.title,
    this.bodyValue,
    this.fieldRecursosTipoValue,
    this.filtro,
    this.cate,
    this.uri,
    this.recurso,
  });

  factory BibliotecaValue.fromMap(dynamic json) => BibliotecaValue(
        nid: json['nid'].toString(),
        title: json['title'].toString(),
        bodyValue: json['body_value'].toString(),
        fieldRecursosTipoValue: json['field_recursos_tipo_value'].toString(),
        filtro: json['filtro'].toString(),
        cate: json['cate'].toString(),
        uri: json['uri'].toString(),
        recurso: json['recurso'].toString(),
      );
  final String? nid;
  final String? title;
  final String? bodyValue;
  final String? fieldRecursosTipoValue;
  final String? filtro;
  final String? cate;
  final String? uri;
  final String? recurso;

  dynamic toMap() => {
        'nid': nid,
        'title': title,
        'body_value': bodyValue,
        'field_recursos_tipo_value': fieldRecursosTipoValue,
        'filtro': filtro,
        'cate': cate,
        'uri': uri,
        'recurso': recurso,
      };
}

class Filtro {
  Filtro({
    this.tid,
    this.name,
  });

  factory Filtro.fromMap(dynamic json) => Filtro(
        tid: json['tid'].toString(),
        name: json['name'].toString(),
      );
  final String? tid;
  final String? name;

  dynamic toMap() => {
        'tid': tid,
        'name': name,
      };
}

class FiltrosCate {
  FiltrosCate({
    this.tid,
    this.name,
    this.parent,
  });

  factory FiltrosCate.fromMap(dynamic json) => FiltrosCate(
        tid: json['tid'].toString(),
        name: json['name'].toString(),
        parent: json['parent'].toString(),
      );
  final String? tid;
  final String? name;
  final String? parent;

  dynamic toMap() => {
        'tid': tid,
        'name': name,
        'parent': parent,
      };
}
