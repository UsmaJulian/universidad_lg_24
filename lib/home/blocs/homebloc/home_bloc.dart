import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:universidad_lg_24/home/models/models.dart';
import 'package:universidad_lg_24/home/services/home_service.dart';

part 'home_event.dart';
part 'home_state.dart';

/// `HomeBloc` es una clase que extiende `Bloc` y maneja los eventos y estados
/// relacionados con la pantalla de inicio (Home) de la aplicación. Utiliza
/// `HomeEvent` para los eventos y `HomeState` para los estados.
///
/// `Bloc` es una biblioteca para manejar estados y eventos en una aplicación
/// de Flutter de una manera estructurada y predecible.
///
/// `Equatable` se utiliza para comparar objetos de manera eficiente, lo cual
/// es importante para la comparación de estados en `Bloc`.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Constructor de la clase `HomeBloc`.
  /// Inicializa el estado inicial como `HomeInitialState`.
  HomeBloc() : super(HomeInitialState()) {
    /// `on<HomeEvent>` es un método para registrar el manejador de eventos para
    /// los eventos del tipo `HomeEvent`.
    ///
    /// En este momento, el manejador de eventos no está implementado
    /// (TODO: implement event handler).
    on<HomeEvent>((event, emit) {
      // TODO: implementar el manejador de eventos
    });
  }

  /// Instancia del servicio `HomeService` para realizar llamadas a la API
  /// relacionadas con la pantalla de inicio.
  HomeService homeService = HomeService();

  /// Método `getHomeContent` para obtener el contenido de la pantalla de inicio.
  /// Este método es asíncrono y devuelve un `Future<HomeModel>`.
  ///
  /// Parámetros opcionales:
  /// - `token`: Token de autenticación para realizar la llamada a la API.
  /// - `uid`: Identificador único del usuario para realizar la llamada a la API.
  ///
  /// Retorna un `Future` que se resuelve con una instancia de `HomeModel`
  /// que contiene los datos obtenidos de la API.
  // Future<HomeModel> getHomeContent({String? token, String? uid}) async {
  //   /// Llama al método `servicegetHomeContent` de `HomeService` pasándole
  //   /// `uid` y `token` como parámetros.
  //   ///
  //   /// Nota: Se utiliza el operador de afirmación no nula (`!`) porque se asume
  //   /// que `uid` y `token` no serán nulos al momento de llamar este método.
  //   return await homeService.servicegetHomeContent(uid!, token!);
  // }
}
