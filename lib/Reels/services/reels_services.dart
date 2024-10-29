import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Reels/exception/reels_exception.dart';
import 'package:universidad_lg_24/Reels/models/reels_like_model.dart';
import 'package:universidad_lg_24/Reels/models/reels_model.dart';

import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/helpers/my_long_print.dart';

abstract class ReelsService {
  Future<ReelsModel> getReelsService({
    String uid,
    String token,
    int pager,
  });
  Future<ReelsLikesModel> getReelsAddLikeService({
    String uid,
    String token,
    String nid,
  });
}

class IsReelsService extends ReelsService {
  @override
  Future<ReelsModel> getReelsService({
    String? uid,
    String? token,
    int? pager,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/reels'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': uid,
        'token': token,
        'pager': pager,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);

      if (request['response']['type'] != 'error') {
        final reels = ReelsModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );

        return reels;
      } else {
        throw ReelsException(
          message: request['response']['message'].toString(),
        );
      }
    } else {
      throw ReelsException(message: 'ocurrió un problema de conexión');
    }
  }

  @override
  Future<ReelsLikesModel> getReelsAddLikeService({
    String? uid,
    String? token,
    String? nid,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/reel/reaction'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': uid,
        'token': token,
        'nid': nid,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);

      if (request['response']['type'] != 'error') {
        final reelsLike = ReelsLikesModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
        myLongPrint('reelsLikeResponse: ${reelsLike.response.type}');
        myLongPrint('reelsLikebody: ${reelsLike.body.likes}');
        return reelsLike;
      } else {
        throw ReelsException(
          message: request['response']['message'].toString(),
        );
      }
    } else {
      throw ReelsException(message: 'ocurrió un problema de conexión');
    }
  }
}
