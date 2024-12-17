import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Resuelvelo/exception/resuelvelo_exception.dart';
import 'package:universidad_lg_24/Resuelvelo/models/add_comment_solve_model.dart';

import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/helpers/my_long_print.dart';

abstract class CommentResuelveloService {
  Future<dynamic> getAddResuelveloCommentService({
    String userId,
    String token,
    String nid,
    String comment,
  });
}

class IsAddResuelveloComment extends CommentResuelveloService {
  @override
  Future<dynamic> getAddResuelveloCommentService({
    String? userId,
    String? token,
    String? nid,
    String? comment,
  }) async {
    myLongPrint('info: $userId, $token, $nid, $comment');
    final response = await http.post(
      Uri.https(baseUrl, 'app/save/comentario'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'token': token,
        'nid': nid,
        'comentario': comment,
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);

      if (request['response']['type'] != 'error') {
        final resuelvelo = AddCommentSolveModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );

        return resuelvelo;
      } else {
        return AddCommentSolveModel(
          response: Response(
            type: request['response']['type'].toString(),
            message: request['response']['message'].toString(),
            code: int.parse(request['response']['code'].toString()),
          ),
          body: Body(idInt: request['body']['idInt'].toString()),
        );
      }
    } else {
      throw ResuelveloException(message: 'ocurrió un problema de conexión');
    }
  }
}
