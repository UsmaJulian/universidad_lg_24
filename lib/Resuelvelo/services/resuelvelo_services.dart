import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Resuelvelo/exception/resuelvelo_exception.dart';
import 'package:universidad_lg_24/Resuelvelo/models/resuelvelo_model.dart';

import 'package:universidad_lg_24/constants.dart';

abstract class ResuelveloService {
  Future<ResuelveloModel> getResuelveloService({
    String uid,
    String token,
    int pager,
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
}
