import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/exceptions/exceptions.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/services/services.dart';

abstract class PerfilService {
  Future<Perfil> getPerfil(String uid, String token);
  Future<String> sentPerfil(
    String uid,
    String token,
    String documento,
    String celular,
    String foto,
  );
}

class IsPerfilService extends PerfilService {
  @override
  Future<Perfil> getPerfil(String uid, String token) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/perfil'),
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
        final perfil =
            Perfil.fromJson(json.decode(response.body) as Map<String, dynamic>);
        return perfil;
      } else {
        throw PerfilException(message: request['status']['message'].toString());
      }
    } else {
      throw PerfilException(message: 'ocurrio un problema de conexion');
    }
  }

  @override
  Future<String> sentPerfil(
    String uid,
    String token,
    String documento,
    String celular,
    String foto,
  ) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/perfi/save'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': uid,
        'token': token,
        'imagen': foto,
        'documento': documento,
        'celular': celular,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      // print(_request);
      if (request['status']['type'] != 'error') {
        await UserSecureStorage.setDocumento(documento);
        await UserSecureStorage.setCelular(celular);

        return request['status']['message'].toString();
      } else {
        throw PerfilException(message: request['status']['message'].toString());
      }
    } else {
      throw PerfilException(message: 'ocurrio un problema de conexion');
    }
  }
}
