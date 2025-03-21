import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/exceptions/authentication_exception.dart';
import 'package:universidad_lg_24/users/services/authentication_service.dart';
import 'package:universidad_lg_24/users/services/secure_storage.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(
    authBloc, {
    required AuthenticationBloc authenticationBloc,
    required AuthenticationService authenticationService,
  })  : _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(RegisterInitialState()) {
    on<RegisterWithEmailAndPasswordEvent>(_onRegisterWithEmailAndPassword);
  }

  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  Future<void> _onRegisterWithEmailAndPassword(
    RegisterWithEmailAndPasswordEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoadingState());
    try {
      // Llamar al servicio de registro
      final user = await _authenticationService.registerWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Almacenar datos del usuario (similar a LoginBloc)
      await UserSecureStorage.setUserId(user!.body.userId);
      await UserSecureStorage.setEmail(user.body.email);
      await UserSecureStorage.setLoginToken(user.body.token);
      await UserSecureStorage.setIsLogin('login');

      // Notificar al AuthenticationBloc
      _authenticationBloc.add(UserRegisterIn(user: user));

      emit(RegisterSuccessState());
      emit(RegisterInitialState()); // Resetear estado
    } on AuthenticationException catch (e) {
      emit(RegisterFailureState(error: e.message));
    } catch (error) {
      emit(
        RegisterFailureState(error: 'Error inesperado: $error'),
      );
    }
  }
}
