part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Evento para registro con email y contraseña
final class RegisterWithEmailAndPasswordEvent extends RegisterEvent {
  RegisterWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
