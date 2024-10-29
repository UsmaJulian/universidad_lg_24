import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/exceptions/exceptions.dart';

import 'package:universidad_lg_24/users/models/models.dart';

abstract class LogrosService {
  Future<Logros> getLogros(String uid, String token);
}

class IsLogrosService extends LogrosService {
  @override
  Future<Logros> getLogros(String uid, String token) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/logros'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': uid,
        'token': token,
      }),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      final request = json.decode(response.body);

      if (request['status']['type'] != 'error') {
        final logros =
            Logros.fromJson(json.decode(response.body) as Map<String, dynamic>);
        return logros;
      } else {
        throw LogrosException(message: request['status']['message'].toString());
      }
    } else {
      throw LogrosException(message: 'ocurrio un problema de conexion');
    }
  }
}
