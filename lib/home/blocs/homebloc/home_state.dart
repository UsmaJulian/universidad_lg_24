part of 'home_bloc.dart';

/// `HomeState` es una clase base sellada que extiende `Equatable`, utilizada
/// para definir los diferentes estados que pueden ser emitidos por el
/// `HomeBloc`.
///
/// La palabra clave `sealed` en Dart indica que esta clase no puede ser
/// extendida fuera del archivo en el que está definida. Esto asegura que todos
/// los subtipos de `HomeState` están definidos en el mismo archivo.
sealed class HomeState extends Equatable {
  /// Constructor constante para `HomeState`.
  const HomeState();

  /// Sobrescribe la propiedad `props` de `Equatable` para proporcionar una
  /// lista de propiedades que serán utilizadas para comparar instancias de
  /// `HomeState`.
  ///
  /// En este caso, retorna una lista vacía ya que `HomeState` no tiene
  /// propiedades propias. Las subclases deben sobrescribir este método para
  /// incluir sus propias propiedades.
  @override
  List<Object> get props => [];
}

/// `HomeInitialState` es una subclase final de `HomeState` que representa el
/// estado inicial de la pantalla de inicio.
///
/// La palabra clave `final` indica que esta clase no puede ser extendida.
final class HomeInitialState extends HomeState {}

/// `HomeLoadingState` es una subclase de `HomeState` que representa el estado
/// de carga de la pantalla de inicio.
class HomeLoadingState extends HomeState {}

/// `HomeSuccessState` es una subclase de `HomeState` que representa el estado
/// exitoso de la pantalla de inicio, cuando el contenido se ha cargado
/// correctamente.
class HomeSuccessState extends HomeState {}

/// `HomeFailureState` es una subclase de `HomeState` que representa el estado
/// de fallo de la pantalla de inicio, cuando ocurre un error al cargar el
/// contenido.
class HomeFailureState extends HomeState {
  /// Constructor constante para `HomeFailureState`.
  ///
  /// Recibe el siguiente parámetro requerido:
  /// - `error`: El mensaje de error que describe el fallo.
  const HomeFailureState({required this.error});

  /// Propiedad `error` que almacena el mensaje de error.
  final String error;

  /// Sobrescribe la propiedad `props` de `Equatable` para proporcionar una
  /// lista de propiedades que serán utilizadas para comparar instancias de
  /// `HomeFailureState`.
  ///
  /// En este caso, la lista incluye `error`.
  @override
  List<Object> get props => [error];
}
