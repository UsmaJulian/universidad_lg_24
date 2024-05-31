part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitialState extends AuthenticationState {}

final class AuthenticationLoadingState extends AuthenticationState {}

final class AuthenticationNotAuthenticatedState extends AuthenticationState {}

final class AuthenticationNotCodeState extends AuthenticationState {
  const AuthenticationNotCodeState({required this.user});
  final User? user;

  @override
  List<Object> get props => [user!];
}

class AuthenticationAuthenticatedState extends AuthenticationState {
  const AuthenticationAuthenticatedState({required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {
  const AuthenticationFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
