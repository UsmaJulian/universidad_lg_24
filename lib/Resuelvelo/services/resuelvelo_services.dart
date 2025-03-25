import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Resuelvelo/exception/resuelvelo_exception.dart';

import 'package:universidad_lg_24/Resuelvelo/models/resuelvelo_model.dart';
import 'package:universidad_lg_24/Resuelvelo/models/resuelvelo_test_model.dart';
import 'package:universidad_lg_24/Resuelvelo/models/save_resuelvelo_test_model.dart';

import 'package:universidad_lg_24/constants.dart';

abstract class ResuelveloService {
  Future<ResuelveloModel> getResuelveloService({
    String uid,
    String token,
    int pager,
  });
  Future<ResuelveloTestModel> getTestResuelvelo({
    String uid,
    String token,
    int nid,
  });
  Future<SaveResuelveloTestModel> saveResuelveloTestAnswers({
    String token,
    String userId,
    int nid,
    List<String> answers,
  });
}

class IsResuelveloService extends ResuelveloService {
  @override
  Future<ResuelveloModel> getResuelveloService({
    String? uid,
    String? token,
    int? pager,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/resuelvelolg'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': uid,
        'token': token,
        'pager': pager,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);

      if (request['response']['type'] != 'error') {
        final resuelvelo = ResuelveloModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );

        return resuelvelo;
      } else {
        throw ResuelveloException(
          message: request['status']['message'].toString(),
        );
      }
    } else {
      throw ResuelveloException(message: 'ocurrió un problema de conexión');
    }
  }

  @override
  Future<ResuelveloTestModel> getTestResuelvelo({
    String? uid,
    String? token,
    int? nid,
  }) async {
    try {
      final response = await http.post(
        Uri.https(baseUrl, 'app/resuelvelolg/test'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'userId': uid,
          'token': token,
          'nid': nid,
        }),
      );
      if (response.statusCode == 200) {
        final request = json.decode(response.body);

        if (request['response']['type'] != 'error') {
          final resuelveloTest = ResuelveloTestModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
          );

          return resuelveloTest;
        } else {
          throw ResuelveloException(
            message: request['status']['message'].toString(),
          );
        }
      } else {
        throw ResuelveloException(message: 'ocurrió un problema de conexión');
      }
    } catch (e) {
      throw ResuelveloException(message: 'ocurrió un problema de conexión');
    }
  }

  @override
  Future<SaveResuelveloTestModel> saveResuelveloTestAnswers({
    String? token,
    String? userId,
    int? nid,
    List<String>? answers,
  }) async {
    log('saveResuelveloTestAnswers: $token $userId $nid $answers');
    try {
      final response = await http.post(
        Uri.https(baseUrl, 'app/resuelvelolg/test/save'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'userId': userId,
          'token': token,
          'nid': nid,
          'answers': answers,
        }),
      );

      if (response.statusCode == 200) {
        final request = json.decode(response.body);
        log(' saveResuelveloTestAnswers: $request');
        if (request['response']['type'] != 'error') {
          final saveResuelveloTest = SaveResuelveloTestModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
          );

          return saveResuelveloTest;
        } else {
          throw ResuelveloException(
            message: request['status']['message'].toString(),
          );
        }
      } else {
        throw ResuelveloException(message: 'ocurrió un problema de conexión');
      }
    } catch (e) {
      throw ResuelveloException(message: 'ocurrió un problema de conexión');
    }
  }
}
