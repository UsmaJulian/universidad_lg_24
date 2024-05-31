import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/services/services.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(AuthenticationService authenticationService)
      : _authenticationService = authenticationService,
        super(AuthenticationInitialState()) {
    on<AppLoadedEvent>((event, emit) {
      _mapAppLoadedToState(event);
    });
  }
  final AuthenticationService? _authenticationService;

  Stream<AuthenticationState> _mapAppLoadedToState(
    AppLoadedEvent event,
  ) async* {
    yield AuthenticationLoadingState();

    try {
      final currentUser = await _authenticationService!.getCurrentUser();
      if (currentUser != null) {
        yield AuthenticationAuthenticatedState(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticatedState();
      }
    } catch (e) {
      yield AuthenticationFailure(
        message: e.toString() ?? 'An unknown error occurred',
      );
    }
  }
}
