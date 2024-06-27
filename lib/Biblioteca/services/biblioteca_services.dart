import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Biblioteca/exception/exception.dart';

import 'package:universidad_lg_24/Biblioteca/models/biblioteca_model.dart';
import 'package:universidad_lg_24/constants.dart';

abstract class BibliotecaService {
  Future<Biblioteca> getBiblioteca({String? userid, String? token});
}

class IsBibliotecaService extends BibliotecaService {
  @override
  Future<Biblioteca> getBiblioteca({String? userid, String? token}) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/biblioteca'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userid.toString(),
        'token': token.toString(),
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);

      if (request['status']['type'] != 'error') {
        final streaming = Biblioteca.fromMap(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return streaming;
      } else {
        throw BibliotecaException(
          message: request['status']['message'].toString(),
        );
      }
    } else {
      throw BibliotecaException(message: 'ocurrio un problema de conexion');
    }
  }
}
