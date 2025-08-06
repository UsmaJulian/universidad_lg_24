import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Evaluaciones/models/ruleta_model.dart';
import 'package:universidad_lg_24/Evaluaciones/models/ruleta_save_model.dart';
import 'package:universidad_lg_24/constants.dart';

class RuletaServices {
  Future<RuletaResponseModel> getRuletaContent(
    String userid,
    String token,
  ) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/resuelvelolg/premios-ruleta'),
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
      if (request['response']['type'] != 'error') {
        final ruletaFJ = RuletaResponseModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return ruletaFJ;
      } else {
        throw 'error';
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  }

  Future<RuletaSaveResponseModel> saveRuletaContent(
    String userid,
    String token,
    int tid,
    String premio,
    int nid,
    String trivia,
  ) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/resuelvelolg/premio/save'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userid,
        'token': token,
        'tid': tid,
        'premio': premio,
        'nid': nid,
        'trivia': trivia,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['response']['type'] != 'error') {
        final ruletaSaveFJ = RuletaSaveResponseModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return ruletaSaveFJ;
      } else {
        throw 'error';
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw 'error';
    }
  }
}
