import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Home/models/new_home_model.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/exceptions/authentication_exception.dart';

class NewHomeService {
  Future<NewHomeModel> newGetServiceContent(String userid, String token) async {
    try {
      final response = await http.post(
        Uri.https(baseUrl, 'app/load-home'),
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
          final newHomeResponse = newHomeModelFromJson(response.body);
          return newHomeResponse;
        } else {
          throw request['status']['message'].toString();
        }
      } else {
        throw AuthenticationException(message: 'Sin internet');
      }
    } catch (e) {
      print(e);
    }
    throw Exception('Unexpected error occurred');
  }
}
