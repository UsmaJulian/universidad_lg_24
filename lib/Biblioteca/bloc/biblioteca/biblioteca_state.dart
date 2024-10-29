part of 'biblioteca_bloc.dart';

sealed class BibliotecaState extends Equatable {
  const BibliotecaState();

  @override
  List<Object> get props => [];
}

final class BibliotecaInitialState extends BibliotecaState {}

class BibliotecaLoad extends BibliotecaState {}

class BibliotecaSucess extends BibliotecaState {
  const BibliotecaSucess(this.data);
  final Biblioteca data;
  @override
  List<Object> get props => [data];
}

class BibliotecaChangeFilter extends BibliotecaState {
  const BibliotecaChangeFilter(this.filtro);
  final String filtro;
  @override
  List<Object> get props => [filtro];
}

class BibliotecaChangeCategoria extends BibliotecaState {
  const BibliotecaChangeCategoria(this.categoria);
  final String categoria;
  @override
  List<Object> get props => [categoria];
}

class ErrorBiblioteca extends BibliotecaState {
  const ErrorBiblioteca(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
