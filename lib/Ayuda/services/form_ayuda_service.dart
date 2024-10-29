import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Ayuda/blocs/ayuda/ayuda_bloc.dart';
import 'package:universidad_lg_24/constants.dart';

abstract class FormAyudaService {
  Future<String> sendFormAyuda({
    String? tema,
    String? pregunta,
    String? user,
    String? token,
  });
}

class IsFormAyudaService extends FormAyudaService {
  @override
  Future<String> sendFormAyuda({
    String? tema,
    String? pregunta,
    String? user,
    String? token,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/ayuda/save'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'userId': user.toString(),
          'token': token.toString(),
          'tema': tema.toString(),
          'pregunta': pregunta.toString(),
        },
      ),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      if (request['status']['type'] != 'error') {
        return request['status']['message'].toString();
      } else {
        throw ErrorAyuda(request['status']['message'].toString());
      }
    } else {
      throw const ErrorAyuda('error en coneccio ');
    }
  }
}
