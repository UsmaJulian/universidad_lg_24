import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/home/models/home_model.dart';
import 'package:universidad_lg_24/users/exceptions/exceptions.dart';

class HomeService {
  Future<HomeModel> servicegetHomeContent(String userid, String token) async {
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

      if (request['status']['type'] != 'error') {
        final homeFJ = HomeModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return homeFJ;
      } else {
        throw request['status']['message'].toString();
      }
    } else {
      throw AuthenticationException(message: 'Sin internet');
    }
  }
}
