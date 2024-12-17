// ignore_for_file: avoid_dynamic_calls, only_throw_errors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Entrenamiento/models/models.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/helpers/my_long_print.dart';

class CursosServices {
  /// Obtener todos los cursos y filtrarlos
  Future<dynamic> serviceGetCursoCategoContent(
    String userid,
    String token,
    String query,
    int page,
  ) async {
    myLongPrint('query: $query');
    final response = await http.post(
      Uri.https(baseUrl, 'app/entrenamiento/$query'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        'userId': userid,
        'token': token,
        'pager': page,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      myLongPrint('request $request');
      if (request['response']['type'] != 'error') {
        // final cursosToJson = EntrenamientoModel.fromJson(
        //   json.decode(response.body) as Map<String, dynamic>,
        // );

        // final cursos = cursosToJson.status!.cursos!.toJson();

        // return cursos[query];
        final cursos = request['body'].asMap();
        return cursos;
      } else {
        throw <dynamic, dynamic>{};
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
    }
    return null;
  }

  /// Obtener información de un curso
  Future<CursoPreview?> serviceGetCursoInfoContent(
    String userid,
    String token,
    String nid,
  ) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/entrenamiento/curso'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userid,
        'token': token,
        'curso': nid,
      }),
    );

    // Validamos response
    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        final cursoPreviewJson = CursoPreview.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return cursoPreviewJson;
      } else {
        throw <dynamic, dynamic>{};
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
    }
    return null;
  }
}
