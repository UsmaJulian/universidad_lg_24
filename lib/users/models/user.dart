// ignore_for_file: avoid_dynamic_calls

import 'package:universidad_lg_24/helpers/my_long_print.dart';
import 'package:universidad_lg_24/users/services/services.dart';

/// Clase que representa a un usuario en la aplicación.
class User {
  User({
    required this.name,
    required this.email,
    this.token,
    this.userId,
    this.username,
    this.documento,
    this.celular,
    this.empresa,
    this.cargo,
    this.mensaje,
    this.codigo,
    this.isLogin,
    this.role,
  });

  /// Factory constructor para crear una instancia de User desde un JSON.
  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      userId: json!['status']['dataUser']['userId'].toString(),
      token: json['status']['dataUser']['token'].toString(),
      codigo: int.parse(json['status']['dataUser']['codigo'].toString()),
      email: json['status']['dataUser']['email'].toString(),
      username: json['status']['dataUser']['username'].toString(),
      name: json['status']['dataUser']['nombre'].toString(),
      documento: json['status']['dataUser']['documento'].toString(),
      celular: json['status']['dataUser']['celular'].toString(),
      empresa: json['status']['dataUser']['empresa'].toString(),
      cargo: json['status']['dataUser']['cargo'].toString(),
      mensaje: json['status']['dataUser']['mensaje'].toString(),
      role: json['status']['dataUser']['role'].toString(),
    );
  }

  final String? userId;
  final String? name;
  final String? email;
  final String? username;
  final String? documento;
  final String? celular;
  final String? empresa;
  final String? cargo;
  final String? mensaje;
  final String? token;
  final int? codigo;
  final int? isLogin;
  final String? role;

  @override
  String toString() =>
      'User { name: $name, email: $email, token: $token, uid:$userId, role: $role }';
}

/// Clase que maneja el almacenamiento seguro del usuario.
class UserStorage {
  UserStorage({
    this.user,
  });

  final User? user;

  /// Crea el almacenamiento del usuario guardando los datos en almacenamiento seguro.
  Future<dynamic> createUserStorage() async {
    myLongPrint('creación del usuario: $user');
    await UserSecureStorage.setUserId(user!.userId.toString());
    await UserSecureStorage.setLoginToken(user!.token.toString());
    await UserSecureStorage.setLoginCodigo(user!.codigo.toString());
    await UserSecureStorage.setEmail(user!.email.toString());
    await UserSecureStorage.setUsername(user!.username.toString());
    await UserSecureStorage.setNombre(user!.name.toString());
    await UserSecureStorage.setDocumento(user!.documento.toString());
    await UserSecureStorage.setCelular(user!.celular.toString());
    await UserSecureStorage.setEmpresa(user!.empresa.toString());
    await UserSecureStorage.setCargo(user!.cargo.toString());
    await UserSecureStorage.setMensaje(user!.mensaje.toString());
    await UserSecureStorage.setRole(user!.role.toString());
  }

  /// Obtiene el almacenamiento del usuario guardando los datos en almacenamiento seguro.

  Future<User?> getUserStorage() async {
    final userId = await UserSecureStorage.getUserId();
    final loginToken = await UserSecureStorage.getLoginToken();
    final loginCodigo = await UserSecureStorage.getLoginCodigo();
    final email = await UserSecureStorage.getEmail();
    final username = await UserSecureStorage.getUsername();
    final nombre = await UserSecureStorage.getNombre();
    final documento = await UserSecureStorage.getDocumento();
    final celular = await UserSecureStorage.getCelular();
    final empresa = await UserSecureStorage.getEmpresa();
    final cargo = await UserSecureStorage.getCargo();
    final mensaje = await UserSecureStorage.getMensaje();
    final role = await UserSecureStorage.getRole();

    if (userId != null && loginToken != null) {
      return User(
        userId: userId,
        token: loginToken,
        codigo: (loginCodigo != null && loginCodigo != 'null')
            ? int.parse(loginCodigo)
            : 0,
        email: email,
        username: username,
        name: nombre,
        documento: documento,
        celular: celular,
        empresa: empresa,
        cargo: cargo,
        mensaje: mensaje,
        role: role,
      );
    } else {
      return null;
    }
  }

  /// Destruye el almacenamiento del usuario limpiando los datos del almacenamiento seguro.
  Future<bool> destroyUserStorage() async {
    await UserSecureStorage.clearUserId();
    await UserSecureStorage.clearLoginToken();
    await UserSecureStorage.clearLoginCodigo();
    await UserSecureStorage.clearEmail();
    await UserSecureStorage.clearUsername();
    await UserSecureStorage.clearNombre();
    await UserSecureStorage.clearDocumento();
    await UserSecureStorage.clearCelular();
    await UserSecureStorage.clearEmpresa();
    await UserSecureStorage.clearCargo();
    await UserSecureStorage.clearMensaje();
    await UserSecureStorage.clearRole();
    return true;
  }
}
