import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Resuelvelo/exception/resuelvelo_exception.dart';
import 'package:universidad_lg_24/Resuelvelo/models/add_comment_solve_model.dart';

import 'package:universidad_lg_24/constants.dart';

abstract class CommentResuelveloService {
  Future<AddCommentSolveModel> getAddResuelveloCommentService({
    String userId,
    String token,
    String nid,
    String comment,
  });
}

class IsAddResuelveloComment extends CommentResuelveloService {
  @override
  Future<AddCommentSolveModel> getAddResuelveloCommentService({
    String? userId,
    String? token,
    String? nid,
    String? comment,
  }) async {
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
        throw ResuelveloException(
          message: request['status']['message'].toString(),
        );
      }
    } else {
      throw ResuelveloException(message: 'ocurrió un problema de conexión');
    }
  }
}
