// ignore_for_file: inference_failure_on_collection_literal

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:universidad_lg_24/Entrenamiento/models/models.dart';
import 'package:universidad_lg_24/constants.dart';

class EntrenamientoService {
  Future<EntrenamientoModel?> servicegetEntrenamientoContent(
    String userid,
    String token,
  ) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/entrenamiento'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userid,
        'token': token,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        print('API Entrenamiento');
        final entrenamientoJson = EntrenamientoModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return entrenamientoJson;
      } else {
        throw {};
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
    }
    return null;
  }

/*   Future<CursoPreview> serviceGetCursoPreviewContent(
      String userid, String token, String curso,) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/entrenamiento/curso'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userid,
        'token': token,
        'curso': curso,
      }),
    );

    // Validamos response
    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        print('API Curso Preview');
        final cursoPreviewJson =
            CursoPreview.fromJson(json.decode(response.body));
        return cursoPreviewJson;
      } else {
        throw null;
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
    }
  } */

  /*  Future<TestEntrada> serviceGetTestEntradaContent(
      String userid, String token, String curso, String leccion,) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/entrenamiento/curso/test-entrada'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userid,
        'token': token,
        'curso': curso,
        'leccion_id': leccion,
      }),
    );

    // Validamos response
    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        print('API Test Entrada');
        final var testEntradaJson =
            TestEntrada.fromJson(json.decode(response.body));
        return testEntradaJson;
      } else {
        throw null;
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
    }
  } */

  /*  Future<SendTestEntrada> serviceSendTestEntrada(String userid, String token,
      String curso, String leccion, Map data,) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/entrenamiento/curso/test-entrada/save'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userid,
        'token': token,
        'curso': curso,
        'leccion_id': leccion,
        'userAnswers': data,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        final sendTestEntradaJson =
            SendTestEntrada.fromJson(json.decode(response.body));

        return sendTestEntradaJson;
      } else {
        throw request['status']['message'];
      }
      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  } */

  /*  Future<Leccion> serviceGetLeccionContent(
      String userid, String token, String curso, String leccion,) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/entrenamiento/curso/ver'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userid,
        'token': token,
        'curso': curso,
        'leccion_id': leccion,
      }),
    );

    // Validamos response
    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        print('API Leccion');
        final var leccionJson = Leccion.fromJson(json.decode(response.body));
        return leccionJson;
      } else {
        throw null;
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
      print('Error Leccion');
    }
  } */

  /*  Future<ActiveTestSalida> serviceActiveTestSalida(
      String userid, String token, String curso,) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/entrenamiento/curso/active'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userid,
        'token': token,
        'curso': curso,
      }),
    );
    print(response.body);
    // Validamos response
    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        print('API Active TestSalida');
        final var activeTSJson =
            ActiveTestSalida.fromJson(json.decode(response.body));
        return activeTSJson;
      } else {
        throw null;
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
      print('Error Leccion');
    }
  } */

/*   Future<TestSalida> serviceGetTestSalidaContent(
      String userid, String token, String curso, String leccion,) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/entrenamiento/curso/test-salida'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userid,
        'token': token,
        'curso': curso,
        'leccion_id': leccion,
      }),
    );

    // Validamos response
    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        print('API Test Entrada');
        final testSalidaJson =
            TestSalida.fromJson(json.decode(response.body));
        return testSalidaJson;
      } else {
        throw null;
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
    }
  } */

  /*  Future<SendTestSalida> serviceSendTestSalida(String userid, String token,
      String curso, String leccion, Map data,) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/entrenamiento/curso/test-salida/save'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userid,
        'token': token,
        'curso': curso,
        'leccion_id': leccion,
        'userAnswers': data,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        final var sendTestSalidaJson =
            SendTestSalida.fromJson(json.decode(response.body));

        return sendTestSalidaJson;
      } else {
        throw request['status']['message'];
      }
      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  } */

/*   Future<RespuestasTestSalida> serviceRespuestasTestSalida(
      String userid, String token, String curso,) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/entrenamiento/curso/test-salida/answers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userid,
        'token': token,
        'curso': curso,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        final respuestasTestSalidaJson =
            RespuestasTestSalida.fromJson(json.decode(response.body));

        return respuestasTestSalidaJson;
      } else {
        throw request['status']['message'];
      }
      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  } */
}
