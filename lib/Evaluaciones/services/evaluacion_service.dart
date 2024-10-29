import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Evaluaciones/models/evaluacion_model.dart';
import 'package:universidad_lg_24/Evaluaciones/models/models.dart';
import 'package:universidad_lg_24/constants.dart';

class EvaluacionService {
  Future<Evaluacion> servicegetEvaluacionesContent(
    String userid,
    String token,
  ) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/evaluaciones'),
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
        final evacionesFJ = Evaluacion.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return evacionesFJ;
      } else {
        throw 'error';
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  }

  Future<SingleEvaluacion> servicegetSingleEvaluacionesContent(
    String userid,
    String token,
    String nid,
  ) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/evaluaciones/detalle'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{'userId': userid, 'token': token, 'eva_nid': nid},
      ),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        final singleEvacionesFJ = SingleEvaluacion.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );

        return singleEvacionesFJ;
      } else {
        throw request['status']['message'].toString();
      }
      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  }

  ////   enviar evaluacion

  Future<SendEvaluacion> sendEvaluacion(
    String? userid,
    String? token,
    String? nid,
    Map<dynamic, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/evaluaciones/detalle/save'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userid,
        'token': token,
        'eva_nid': nid,
        'respuestas': data,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        final resEvacionesFJ = SendEvaluacion.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );

        return resEvacionesFJ;
      } else {
        throw request['status']['message'].toString();
      }
      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  }

  // consultar resultados

  Future<RespuestaEvaluacion> getResultados(
    String userid,
    String token,
    String nid,
  ) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/evaluaciones/detalle/respuestas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userid,
        'token': token,
        'eva_nid': nid,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        final resRespuentas = RespuestaEvaluacion.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );

        return resRespuentas;
      } else {
        throw request['status']['message'].toString();
      }
      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  }
}
