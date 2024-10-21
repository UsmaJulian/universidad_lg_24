import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Calendario/exception/calendario_exception.dart';
import 'package:universidad_lg_24/Calendario/models/calendario_model.dart';
import 'package:universidad_lg_24/constants.dart';

abstract class CalendarioService {
  Future<CalendarioModel> getCalendarioService({
    String uid,
    String token,
  });
}

class IsCalendarioService extends CalendarioService {
  @override
  Future<CalendarioModel> getCalendarioService({
    String? uid,
    String? token,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/calendario'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': uid,
        'token': token,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);

      if (request['response']['type'] != 'error') {
        final reels = CalendarioModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );

        return reels;
      } else {
        throw CalendarioException(
          message: request['response']['message'].toString(),
        );
      }
    } else {
      throw CalendarioException(message: 'ocurrió un problema de conexión');
    }
  }
}
