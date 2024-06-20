import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Noticias/exceptions/exception.dart';
import 'package:universidad_lg_24/Noticias/models/models.dart';
import 'package:universidad_lg_24/constants.dart';

abstract class ServiceNoticiasSingle {
  Future<SingleNoticia> getSteamingSingleData({
    String userid,
    String token,
    String nid,
  });
}

class IsServiceNoticiasSingle extends ServiceNoticiasSingle {
  @override
  Future<SingleNoticia> getSteamingSingleData({
    String? userid,
    String? token,
    String? nid,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/noticias/detalle'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': userid.toString(),
        'token': token.toString(),
        'nid': nid.toString(),
      }),
    );

    if (response.statusCode == 200) {
      final request = jsonDecode(response.body);

      if (request['status']['type'] != 'error') {
        final streaming = SingleNoticia.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return streaming;
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
