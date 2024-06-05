part of 'home_bloc.dart';

/// `HomeEvent` es una clase base sellada que extiende `Equatable`, la cual es
/// utilizada para definir los eventos que pueden ser emitidos hacia el
/// `HomeBloc`.
///
/// La palabra clave `sealed` en Dart es usada para indicar que esta clase no
/// puede ser extendida fuera del archivo en el que está definida. Esto asegura
/// que todos los subtipos de `HomeEvent` están definidos en el mismo archivo.
sealed class HomeEvent extends Equatable {
  /// Constructor constante para `HomeEvent`.
  const HomeEvent();

  /// Sobrescribe la propiedad `props` de `Equatable` para proporcionar una
  /// lista de propiedades que serán utilizadas para comparar instancias de
  /// `HomeEvent`.
  ///
  /// En este caso, retorna una lista vacía ya que `HomeEvent` no tiene
  /// propiedades propias. Las subclases deben sobrescribir este método para
  /// incluir sus propias propiedades.
  @override
  List<Object> get props => [];
}

/// `GetHomeContentEvent` es una subclase de `HomeEvent` que representa el
/// evento de obtener el contenido de la pantalla de inicio.
///
/// Este evento requiere `uid` y `token` como parámetros, que son necesarios
/// para realizar la solicitud a la API.
class GetHomeContentEvent extends HomeEvent {
  /// Constructor constante para `GetHomeContentEvent`.
  ///
  /// Recibe los siguientes parámetros requeridos:
  /// - `uid`: El identificador único del usuario.
  /// - `token`: El token de autenticación.
  const GetHomeContentEvent({required this.uid, required this.token});

  /// Propiedad `uid` que almacena el identificador único del usuario.
  final String uid;

  /// Propiedad `token` que almacena el token de autenticación.
  final String token;

  /// Sobrescribe la propiedad `props` de `Equatable` para proporcionar una
  /// lista de propiedades que serán utilizadas para comparar instancias de
  /// `GetHomeContentEvent`.
  ///
  /// En este caso, la lista incluye `uid` y `token`.
  @override
  List<Object> get props => [uid, token];
}
