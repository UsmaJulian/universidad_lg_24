part of 'ayuda_bloc.dart';

sealed class AyudaState extends Equatable {
  const AyudaState();

  @override
  List<Object> get props => [];
}

final class AyudaInitialState extends AyudaState {}

class AyudaLoader extends AyudaState {
  @override
  List<Object> get props => [];
}

class AyudaSuccess extends AyudaState {
  const AyudaSuccess(this.data);
  final Ayuda data;

  @override
  List<Object> get props => [data];
}

class ErrorAyuda extends AyudaState {
  const ErrorAyuda(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
