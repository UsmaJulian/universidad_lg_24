part of 'perfil_bloc.dart';

sealed class PerfilState extends Equatable {
  const PerfilState();

  @override
  List<Object> get props => [];
}

final class PerfilInitialState extends PerfilState {}

class PerfilLoad extends PerfilState {}

class PerfilSuccess extends PerfilState {
  const PerfilSuccess(this.data);
  final Perfil data;

  @override
  List<Object> get props => [data];
}

class ChangeImage extends PerfilState {
  const ChangeImage(this.path);
  final String path;
  @override
  List<Object> get props => [path];
}

class PerfilSend extends PerfilState {
  const PerfilSend(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class ErrorPerfil extends PerfilState {
  const ErrorPerfil(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
