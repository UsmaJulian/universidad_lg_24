part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Fired just after the app is launched
class AppLoadedEvent extends AuthenticationEvent {}

// Fired when a user has successfully logged in
class UserLoggedIn extends AuthenticationEvent {
  const UserLoggedIn({required this.user});
  final User? user;

  @override
  List<Object> get props => [user!];
}

class UserLoggedCodigo extends AuthenticationEvent {
  const UserLoggedCodigo({required this.user});
  final User? user;

  @override
  List<Object> get props => [user!];
}

// Fired when the user has logged out
class UserLoggedOut extends AuthenticationEvent {
  const UserLoggedOut();
}
