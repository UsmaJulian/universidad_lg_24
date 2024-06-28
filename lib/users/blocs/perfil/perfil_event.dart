part of 'perfil_bloc.dart';

sealed class PerfilEvent extends Equatable {
  const PerfilEvent();

  @override
  List<Object> get props => [];
}

class GetPerfilEvent extends PerfilEvent {
  const GetPerfilEvent({this.user, this.token});
  final String? user;
  final String? token;
  @override
  List<Object> get props => [];
}

class SetImagePerfilEvent extends PerfilEvent {
  const SetImagePerfilEvent(this.path);
  final String? path;

  @override
  List<Object> get props => [path!];
}

class SendPerfilEvent extends PerfilEvent {
  const SendPerfilEvent({
    this.user,
    this.token,
    this.documento,
    this.celular,
    this.imagen,
  });
  final String? user;
  final String? token;
  final String? documento;
  final String? celular;
  final String? imagen;
  @override
  List<Object> get props => [documento!, celular!, imagen!];
}
