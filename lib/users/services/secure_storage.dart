import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  // Crear una instancia de FlutterSecureStorage
  static const _storage = FlutterSecureStorage();

  // Definir claves para almacenar varios detalles del usuario
  static const _keyUserId = 'userId';
  static const _keyToken = 'tokenLogin';
  static const _keyCodigo = 'codigoLogin';

  static const _keyUsername = 'username';
  static const _keyNombre = 'nombre';
  static const _keyEmail = 'email';
  static const _keyDocumento = 'documento';
  static const _keyCelular = 'celular';
  static const _keyEmpresa = 'empresa';
  static const _keyCargo = 'cargo';
  static const _keyMensaje = 'mensaje';
  static const _keyIsLogin = 'isLogin';

  // Métodos para manejar UserId

  // Guardar UserId en almacenamiento seguro
  static Future<void> setUserId(String userId) async =>
      _storage.write(key: _keyUserId, value: userId);

  // Recuperar UserId del almacenamiento seguro
  static Future<String?> getUserId() async => _storage.read(key: _keyUserId);

  // Limpiar UserId del almacenamiento seguro
  static Future<void> clearUserId() async => _storage.delete(key: _keyUserId);

  // Métodos para manejar el token

  // Guardar el token de inicio de sesión en almacenamiento seguro
  static Future<void> setLoginToken(String token) async =>
      _storage.write(key: _keyToken, value: token);

  // Recuperar el token de inicio de sesión del almacenamiento seguro
  static Future<String?> getLoginToken() async => _storage.read(key: _keyToken);

  // Limpiar el token de inicio de sesión del almacenamiento seguro
  static Future<void> clearLoginToken() async =>
      _storage.delete(key: _keyToken);

  // Métodos para manejar el código de inicio de sesión

  // Guardar el código de inicio de sesión en almacenamiento seguro
  static Future<void> setLoginCodigo(String codigo) async =>
      _storage.write(key: _keyCodigo, value: codigo);

  // Recuperar el código de inicio de sesión del almacenamiento seguro
  static Future<String?> getLoginCodigo() async =>
      _storage.read(key: _keyCodigo);

  // Limpiar el código de inicio de sesión del almacenamiento seguro
  static Future<void> clearLoginCodigo() async =>
      _storage.delete(key: _keyCodigo);

  // Métodos para manejar el nombre de usuario

  // Guardar el nombre de usuario en almacenamiento seguro
  static Future<void> setUsername(String username) async =>
      _storage.write(key: _keyUsername, value: username);

  // Recuperar el nombre de usuario del almacenamiento seguro
  static Future<String?> getUsername() async =>
      _storage.read(key: _keyUsername);

  // Limpiar el nombre de usuario del almacenamiento seguro
  static Future<void> clearUsername() async =>
      _storage.delete(key: _keyUsername);

  // Métodos para manejar el nombre

  // Guardar el nombre en almacenamiento seguro
  static Future<void> setNombre(String nombre) async =>
      _storage.write(key: _keyNombre, value: nombre);

  // Recuperar el nombre del almacenamiento seguro
  static Future<String?> getNombre() async => _storage.read(key: _keyNombre);

  // Limpiar el nombre del almacenamiento seguro
  static Future<void> clearNombre() async => _storage.delete(key: _keyNombre);

  // Métodos para manejar el email

  // Guardar el email en almacenamiento seguro
  static Future<void> setEmail(String email) async =>
      _storage.write(key: _keyEmail, value: email);

  // Recuperar el email del almacenamiento seguro
  static Future<String?> getEmail() async => _storage.read(key: _keyEmail);

  // Limpiar el email del almacenamiento seguro
  static Future<void> clearEmail() async => _storage.delete(key: _keyEmail);

  // Métodos para manejar el documento

  // Guardar el documento en almacenamiento seguro
  static Future<void> setDocumento(String documento) async =>
      _storage.write(key: _keyDocumento, value: documento);

  // Recuperar el documento del almacenamiento seguro
  static Future<String?> getDocumento() async =>
      _storage.read(key: _keyDocumento);

  // Limpiar el documento del almacenamiento seguro
  static Future<void> clearDocumento() async =>
      _storage.delete(key: _keyDocumento);

  // Métodos para manejar el celular

  // Guardar el celular en almacenamiento seguro
  static Future<void> setCelular(String celular) async =>
      _storage.write(key: _keyCelular, value: celular);

  // Recuperar el celular del almacenamiento seguro
  static Future<String?> getCelular() async => _storage.read(key: _keyCelular);

  // Limpiar el celular del almacenamiento seguro
  static Future<void> clearCelular() async => _storage.delete(key: _keyCelular);

  // Métodos para manejar la empresa

  // Guardar la empresa en almacenamiento seguro
  static Future<void> setEmpresa(String empresa) async =>
      _storage.write(key: _keyEmpresa, value: empresa);

  // Recuperar la empresa del almacenamiento seguro
  static Future<String?> getEmpresa() async => _storage.read(key: _keyEmpresa);

  // Limpiar la empresa del almacenamiento seguro
  static Future<void> clearEmpresa() async => _storage.delete(key: _keyEmpresa);

  // Métodos para manejar el cargo

  // Guardar el cargo en almacenamiento seguro
  static Future<void> setCargo(String cargo) async =>
      _storage.write(key: _keyCargo, value: cargo);

  // Recuperar el cargo del almacenamiento seguro
  static Future<String?> getCargo() async => _storage.read(key: _keyCargo);

  // Limpiar el cargo del almacenamiento seguro
  static Future<void> clearCargo() async => _storage.delete(key: _keyCargo);

  // Métodos para manejar el mensaje

  // Guardar el mensaje en almacenamiento seguro
  static Future<void> setMensaje(String mensaje) async =>
      _storage.write(key: _keyMensaje, value: mensaje);

  // Recuperar el mensaje del almacenamiento seguro
  static Future<String?> getMensaje() async => _storage.read(key: _keyMensaje);

  // Limpiar el mensaje del almacenamiento seguro
  static Future<void> clearMensaje() async => _storage.delete(key: _keyMensaje);

  // Métodos para manejar el estado de inicio de sesión

  // Guardar el estado de inicio de sesión en almacenamiento seguro
  static Future<void> setIsLogin(String isLogin) async =>
      _storage.write(key: _keyIsLogin, value: isLogin);

  // Recuperar el estado de inicio de sesión del almacenamiento seguro
  static Future<String?> getIsLogin() async => _storage.read(key: _keyIsLogin);

  // Limpiar el estado de inicio de sesión del almacenamiento seguro
  static Future<void> clearIsLogin() async => _storage.delete(key: _keyIsLogin);
}
