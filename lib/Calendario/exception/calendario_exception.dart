class CalendarioException implements Exception {
  CalendarioException({this.message = 'a ocurrido un error'});
  final String message;
}
