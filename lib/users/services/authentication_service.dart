// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/helpers/my_long_print.dart';
import 'package:universidad_lg_24/users/exceptions/exceptions.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/models/register_user.dart';
import 'package:universidad_lg_24/users/services/services.dart';

sealed class AuthenticationService {
  Future<User?> getCurrentUser();
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<RegisterUser?> registerWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}

class IsAuthenticationService extends AuthenticationService {
  @override
  Future<User?> getCurrentUser() async {
    final isLogin = await UserSecureStorage.getIsLogin();

    if (isLogin != null) {
      final token = await UserSecureStorage.getLoginToken();
      final uid = await UserSecureStorage.getUserId();

      final response = await http.post(
        Uri.https(baseUrl, 'app/validate-session'),
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
          // Usar UserStorage para obtener todos los campos del usuario
          final userStorage = UserStorage();
          return userStorage.getUserStorage();
        } else {
          return null;
        }
      } else {
        throw AuthenticationException(
          message: 'ocurrió un problema de conexión',
        );
      }
    }

    return null;
  }

  @override
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.https(baseUrl, 'app/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email.trim(),
        'password': password.trim(),
      }),
    );

    if (response.statusCode == 200) {
      final request = json.decode(response.body);
      myLongPrint('request: $request');
      if (request['status']['type'] != 'error') {
        final user = User(
          userId: request['status']['dataUser']['userId'].toString(),
          token: request['status']['dataUser']['token'].toString(),
          codigo: int.parse(request['status']['dataUser']['codigo'].toString()),
          email: request['status']['dataUser']['email'].toString(),
          username: request['status']['dataUser']['username'].toString(),
          name: request['status']['dataUser']['nombre'].toString(),
          documento: request['status']['dataUser']['documento'].toString(),
          celular: request['status']['dataUser']['celular'].toString(),
          empresa: request['status']['dataUser']['empresa'].toString(),
          cargo: request['status']['dataUser']['cargo'].toString(),
          mensaje: request['status']['dataUser']['mensaje'].toString(),
          role: request['status']['dataUser']['role'].toString(),
          userRuleta:
              int.parse(request['status']['dataUser']['userRuleta'].toString()),
        );

        final userStorage = UserStorage(user: user);
        await userStorage.createUserStorage();
        return user;
      } else {
        throw AuthenticationException(
          message: request['status']['message'].toString(),
        );
      }

      // throw AuthenticationException(message: 'Wrong username or password');
    } else {
      throw AuthenticationException(message: 'ocurrió un problema de conexión');
    }
  }

  @override
  Future<RegisterUser?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.https(baseUrl, 'app/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email.trim(),
          'password': password.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final request = json.decode(response.body);
        myLongPrint('request: $request');
        if (request['status']['type'] != 'error') {
          final user = RegisterUser(
            statusRegister: StatusRegister.fromJson(
              request['status'] as Map<String, dynamic>,
            ),
            body: Body.fromJson(request['body'] as Map<String, dynamic>),
          );
          final userForStorage = User(
            userId: user.body.userId,
            email: user.body.email,
            name: user.body.username,
            username: user.body.username,
            token: user.body.token,
            role: user.body.role,
            userRuleta: user.body.userRuleta,
          );
          final userStorage = UserStorage(user: userForStorage);
          await userStorage.createUserStorage();
          return user;
        } else {
          throw AuthenticationException(
            message: request['status']['message'].toString(),
          );
        }
      } else {
        throw AuthenticationException(
          message: 'ocurrió un problema de conexión',
        );
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<dynamic> signOut() async {
    final token = await UserSecureStorage.getLoginToken();

    if (token != null) {
      final userStorage = UserStorage();
      return userStorage.destroyUserStorage();
    }
    return;
  }
}
