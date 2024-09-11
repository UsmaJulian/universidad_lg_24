import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/Juegos/models/juegos_content_model.dart';
import 'package:universidad_lg_24/Juegos/models/juegos_model.dart';
import 'package:universidad_lg_24/Juegos/models/save_juegos_model.dart';
import 'package:universidad_lg_24/constants.dart';

sealed class JuegosServices {
  Future<JuegosModel> getJuegosBasic({String user, String token, int pager});

  Future<JuegosModel> getJuegosInterm({String user, String token, int pager});

  Future<JuegosModel> getJuegosAvanz({String user, String token, int pager});

  Future<JuegosContent> getJuegosContent({String user, String token, int nid});

  Future<SaveJuegosModel> saveJuegosAnswers({
    String user,
    String token,
    int nid,
    List<String> answers,
  });

  Stream<JuegosModel> getJuegosBasicStream({
    String? user,
    String? token,
    int? pager,
  }) async* {
    while (true) {
      yield await getJuegosBasic(user: user!, token: token!, pager: pager!);
      await Future<void>.delayed(
        const Duration(seconds: 5),
      ); // Ajusta el intervalo según sea necesario
    }
  }
}

class IsJuegosServices extends JuegosServices {
  @override
  Future<JuegosModel> getJuegosBasic({
    String? user,
    String? token,
    int? pager,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, '/app/trivias/basico'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'userId': user.toString(),
          'token': token.toString(),
          'pager': pager,
        },
      ),
    );
    if (response.statusCode == 200) {
      return JuegosModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load juegos');
    }
  }

  @override
  Future<JuegosModel> getJuegosInterm({
    String? user,
    String? token,
    int? pager,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, '/app/trivias/intermedio'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'userId': user.toString(),
          'token': token.toString(),
          'pager': pager,
        },
      ),
    );
    if (response.statusCode == 200) {
      return JuegosModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load juegos');
    }
  }

  @override
  Future<JuegosModel> getJuegosAvanz({
    String? user,
    String? token,
    int? pager,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, '/app/trivias/avanzado'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'userId': user.toString(),
          'token': token.toString(),
          'pager': pager,
        },
      ),
    );
    if (response.statusCode == 200) {
      return JuegosModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load juegos');
    }
  }

  @override
  Future<JuegosContent> getJuegosContent({
    String? user,
    String? token,
    int? nid,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, '/app/trivia/interna'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'userId': user.toString(),
          'token': token.toString(),
          'nid': nid,
        },
      ),
    );
    if (response.statusCode == 200) {
      return JuegosContent.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load juegos');
    }
  }

  @override
  Future<SaveJuegosModel> saveJuegosAnswers({
    String? user,
    String? token,
    int? nid,
    List<String>? answers,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, '/app/trivia/save'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'userId': user.toString(),
          'token': token.toString(),
          'nid': nid,
          'answers': answers,
        },
      ),
    );
    if (response.statusCode == 200) {
      return SaveJuegosModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load juegos');
    }
  }
}
