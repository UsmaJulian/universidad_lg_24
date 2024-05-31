class AuthenticationException implements Exception {
  AuthenticationException({this.message = 'A ocurrido un error'});
  final String message;
}
