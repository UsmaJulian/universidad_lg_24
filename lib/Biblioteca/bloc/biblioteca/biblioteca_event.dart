part of 'biblioteca_bloc.dart';

sealed class BibliotecaEvent extends Equatable {
  const BibliotecaEvent();

  @override
  List<Object> get props => [];
}

class GetBibliotecaEvent extends BibliotecaEvent {
  const GetBibliotecaEvent({this.user, this.token});
  final String? user;
  final String? token;
  @override
  List<Object> get props => [user!, token!];
}

class FiterBibliotecaEvent extends BibliotecaEvent {
  const FiterBibliotecaEvent({this.filtro});
  final String? filtro;
  @override
  List<Object> get props => [filtro!];
}

class CategoriaBibliotecaEvent extends BibliotecaEvent {
  const CategoriaBibliotecaEvent({this.categoria});
  final String? categoria;
  @override
  List<Object> get props => [categoria!];
}
