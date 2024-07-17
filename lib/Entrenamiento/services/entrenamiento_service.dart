// ignore_for_file: inference_failure_on_collection_literal, strict_raw_type

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Entrenamiento/models/active_test_salida_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/leccion_model.dart';

import 'package:universidad_lg_24/Entrenamiento/models/models.dart';
import 'package:universidad_lg_24/Entrenamiento/models/respuestas_test_salida_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/send_test_entrada_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/send_test_salida_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/test_entrada_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/test_salida_model.dart';
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

  Future<CursoPreview?> serviceGetCursoPreviewContent(
    String userid,
    String token,
    String curso,
  ) async {
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
        final cursoPreviewJson = CursoPreview.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return cursoPreviewJson;
      } else {
        throw {};
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
    }
    return null;
  }

  Future<TestEntrada?> serviceGetTestEntradaContent(
    String userid,
    String token,
    String curso,
    String leccion,
  ) async {
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
        final testEntradaJson = TestEntrada.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return testEntradaJson;
      } else {
        throw {};
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
    }
    return null;
  }

  Future<SendTestEntrada> serviceSendTestEntrada(
    String userid,
    String token,
    String curso,
    String leccion,
    Map data,
  ) async {
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
        final sendTestEntradaJson = SendTestEntrada.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );

        return sendTestEntradaJson;
      } else {
        throw request['status']['message'].toString();
      }
      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  }

  Future<Leccion?> serviceGetLeccionContent(
    String userid,
    String token,
    String curso,
    String leccion,
  ) async {
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
        final leccionJson = Leccion.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return leccionJson;
      } else {
        throw {};
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
      print('Error Leccion');
    }
    return null;
  }

  Future<ActiveTestSalida?> serviceActiveTestSalida(
    String userid,
    String token,
    String curso,
  ) async {
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
        final activeTSJson = ActiveTestSalida.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return activeTSJson;
      } else {
        throw {};
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
      print('Error Leccion');
    }
    return null;
  }

  Future<TestSalida?> serviceGetTestSalidaContent(
    String userid,
    String token,
    String curso,
    String leccion,
  ) async {
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
        final testSalidaJson = TestSalida.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return testSalidaJson;
      } else {
        throw {};
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      // throw HomeException(message: 'ocurrio un problema de conexion');
    }
    return null;
  }

  Future<SendTestSalida> serviceSendTestSalida(
    String userid,
    String token,
    String curso,
    String leccion,
    Map data,
  ) async {
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
        final sendTestSalidaJson = SendTestSalida.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );

        return sendTestSalidaJson;
      } else {
        throw request['status']['message'].toString();
      }
      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  }

  Future<RespuestasTestSalida> serviceRespuestasTestSalida(
    String userid,
    String token,
    String curso,
  ) async {
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
        final respuestasTestSalidaJson = RespuestasTestSalida.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );

        return respuestasTestSalidaJson;
      } else {
        throw request['status']['message'].toString();
      }
      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  }
}
