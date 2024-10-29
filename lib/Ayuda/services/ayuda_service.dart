import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Ayuda/exception/ayuda_exception.dart';
import 'package:universidad_lg_24/Ayuda/models/ayuda_model.dart';
import 'package:universidad_lg_24/constants.dart';

abstract class AyudaService {
  Future<Ayuda> getAyuda({String user, String token});
}

class IsAyudaService extends AyudaService {
  @override
  Future<Ayuda> getAyuda({String? user, String? token}) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/ayuda'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'userId': user.toString(),
          'token': token.toString(),
        },
      ),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);

      if (request['status']['type'] != 'error') {
        return Ayuda.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        throw AyudaException(mesaje: request['status']['message'].toString());
      }
    } else {
      throw AyudaException(mesaje: 'ocurrio un problema de conexion');
    }
  }
}
