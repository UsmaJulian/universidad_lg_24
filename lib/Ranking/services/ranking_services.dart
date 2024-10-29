import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Ranking/exception/ranking_exception.dart';
import 'package:universidad_lg_24/Ranking/models/ranking_model.dart';
import 'package:universidad_lg_24/constants.dart';

abstract class RankingService {
  Future<Ranking> getRankingService({String uid, String token});
}

class IsRankingService extends RankingService {
  @override
  Future<Ranking> getRankingService({String? uid, String? token}) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/ranking'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userId': uid!,
        'token': token!,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);

      if (request['status']['type'] != 'error') {
        final streaming = Ranking.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        return streaming;
      } else {
        throw RankingException(
          message: request['status']['message'].toString(),
        );
      }
    } else {
      throw RankingException(message: 'ocurrió un problema de conexión');
    }
  }
}
