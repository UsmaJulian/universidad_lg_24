import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:universidad_lg_24/users/blocs/authentication/authentication_bloc.dart';
import 'package:universidad_lg_24/users/exceptions/exceptions.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/services/authentication_service.dart';
import 'package:universidad_lg_24/users/services/services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
    AuthenticationBloc authenticationBloc,
    AuthenticationService authenticationService,
  )   : _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(LoginInitialState()) {
    on<LoginInWithEmailButtonPressedEvent>(_mapLoginWithEmailToState);
    on<CodigoValidateButtonPressedEvent>(_mapLoginCodigoState);
  }
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  FutureOr<void> _mapLoginWithEmailToState(
    LoginInWithEmailButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    final user = await _authenticationService.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );
    if (user != null) {
      // _authenticationBloc.add(UserLoggedIn(user: user));
      _authenticationBloc.add(UserLoggedCodigo(user: user));
      emit(LoginSuccessState());
      emit(LoginInitialState());
    } else {
      emit(LoginFailureState(error: 'Something very weird just happened'));
    }
  }

  FutureOr<void> _mapLoginCodigoState(
    CodigoValidateButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    try {
      final userCodeStorage = UserSecureStorage.getLoginCodigo().toString();
      if (userCodeStorage == event.codigo) {
        final token = await UserSecureStorage.getLoginToken();
        final name = await UserSecureStorage.getNombre();
        final uid = await UserSecureStorage.getUserId();
        final email = await UserSecureStorage.getEmail();
        await UserSecureStorage.setIsLogin('login');
        final user = User(name: name, email: email, userId: uid, token: token);

        _authenticationBloc.add(UserLoggedIn(user: user));

        emit(LoginSuccessState());
        emit(LoginInitialState());
      } else {
        emit(LoginFailureState(error: 'Codigo no valido'));
      }
    } on AuthenticationException catch (e) {
      emit(LoginFailureState(error: e.message));
    } catch (err) {
      emit(
        LoginFailureState(
          error: err.toString(),
        ),
      );
    }
  }
}
