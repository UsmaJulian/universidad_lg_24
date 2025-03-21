import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:universidad_lg_24/home/views/globals.dart' as globals;

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/models/register_user.dart';
import 'package:universidad_lg_24/users/services/services.dart';
import 'package:universidad_lg_24/users/views/login/login_view.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// [AuthenticationBloc] maneja el flujo de autenticación de usuarios.
/// Se encarga de recibir eventos y emitir estados relacionados con la
/// autenticación.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// Constructor que inicializa el Bloc de autenticación con el servicio
  ///  proporcionado.
  /// También define los manejadores de eventos.
  AuthenticationBloc(AuthenticationService authenticationService)
      : _authenticationService = authenticationService,
        super(AuthenticationInitialState()) {
    on<AppLoadedEvent>(_onMapAppLoadedToState);
    on<UserRegisterIn>(_onMapUserRegisterInToState);
    on<UserLoggedIn>(_onMapUserLoggedInToState);
    on<UserLoggedCodigo>(_onMapUserLoggedCodigoToState);
    on<UserLoggedOut>(_onUserLoggedOut);
  }

  /// Servicio de autenticación para manejar las operaciones de autenticación.
  final AuthenticationService? _authenticationService;

  /// Maneja el evento [AppLoadedEvent] para verificar el estado de
  /// autenticación del usuario cuando la aplicación se carga.
  FutureOr<void> _onMapAppLoadedToState(
    AppLoadedEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      // Intenta obtener el usuario actual desde el servicio de autenticación.
      final currentUser = await _authenticationService!.getCurrentUser();
      if (currentUser != null) {
        // Si el usuario actual existe, emite el estado de autenticación
        // autenticado.
        emit(AuthenticationAuthenticatedState(user: currentUser));
      } else {
        // Si el usuario actual no existe, emite el estado de no autenticado.
        emit(AuthenticationNotAuthenticatedState());
      }
    } catch (e) {
      // En caso de error, emite el estado de falla de autenticación.
      emit(AuthenticationFailure(message: e.toString()));
    }
  }

  FutureOr<void> _onMapUserRegisterInToState(
    UserRegisterIn event,
    Emitter<AuthenticationState> emit,
  ) {
    final user = User(
      mensaje: event.user!.statusRegister.message,
      userId: event.user!.body.userId,
      email: event.user!.body.email,
      name: event.user!.body.username,
      username: event.user!.body.username,
      token: event.user!.body.token,
      role: event.user!.body.role,
    );
    emit(AuthenticationAuthenticatedState(user: user));
  }

  /// Maneja el evento [UserRegisterIn] para actualizar el estado cuando un
  ///  usuario ha iniciado sesión.
  FutureOr<void> _onMapUserLoggedInToState(
    UserLoggedIn event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(AuthenticationAuthenticatedState(user: event.user!));
  }

  /// Maneja el evento [UserLoggedCodigo] para actualizar el estado cuando un
  ///  usuario ha iniciado sesión pero necesita un código.
  FutureOr<void> _onMapUserLoggedCodigoToState(
    UserLoggedCodigo event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(AuthenticationNotCodeState(user: event.user));
  }

  /// Maneja el evento [UserLoggedOut] para actualizar el estado cuando un
  ///  usuario ha cerrado sesión.
  // FutureOr<void> _onMapUserLoggedOutToState(
  //   UserLoggedOut event,
  //   Emitter<AuthenticationState> emit,
  // ) async {
  //   try {
  //     // Intenta cerrar sesión utilizando el servicio de autenticación.
  //     await _authenticationService!.signOut();
  //     // Si la sesión se cierra correctamente, emite el estado de no
  //     // autenticado.
  //     emit(AuthenticationNotAuthenticatedState());
  //   } catch (e) {
  //     // En caso de error, emite el estado de falla de autenticación.
  //     emit(AuthenticationFailure(message: e.toString()));
  //   }
  // }
  Future<void> _onUserLoggedOut(
    UserLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    var attempt = 0; // Contador de intentos
    var success = false; // Indicador de éxito

    while (attempt < 5 && !success) {
      try {
        attempt++;

        await _clearUserData();

        // Emitir el estado de no autenticado
        emit(AuthenticationNotAuthenticatedState());

        // Redirigir a la pantalla de LoginView
        await Navigator.of(globals.appNavigator!.currentContext!)
            .pushAndRemoveUntil(
          MaterialPageRoute<void>(builder: (context) => const LoginView()),
          (route) => false,
        );

        success = true; // Si todas las operaciones tienen éxito
      } catch (e) {
        if (attempt >= 5) {
          // Manejar errores si los intentos fallan
          emit(
            const AuthenticationFailure(
              message: 'Error al cerrar sesión después de varios intentos.',
            ),
          );
        }
      }
    }
  }

  Future<void> _clearUserData() async {
    // Ejemplo: Eliminar datos de SharedPreferences
    await const FlutterSecureStorage().deleteAll();
  }
}
