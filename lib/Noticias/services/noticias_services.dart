import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Noticias/exceptions/exception.dart';
import 'package:universidad_lg_24/Noticias/models/models.dart';
import 'package:universidad_lg_24/constants.dart';

abstract class NoticiasService {
  Future<Noticias> getNoticiasData({
    required String userid,
    required String token,
  });
}

class IsNoticiasService extends NoticiasService {
  @override
  Future<Noticias> getNoticiasData({
    required String userid,
    required String token,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/noticias'),
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
        final noticiasJson = Noticias.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return noticiasJson;
      } else {
        throw NoticiasException(
          message: request['status']['message'].toString(),
        );
      }
    } else {
      throw NoticiasException(message: 'ocurrio un problema de conexion');
    }
  }
}
