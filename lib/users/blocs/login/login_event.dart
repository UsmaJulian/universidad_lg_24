part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInWithEmailButtonPressedEvent extends LoginEvent {
  LoginInWithEmailButtonPressedEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class CodigoValidateButtonPressedEvent extends LoginEvent {
  CodigoValidateButtonPressedEvent({required this.codigo});
  final String codigo;
}
