part of 'formulario_bloc.dart';

sealed class FormularioState extends Equatable {
  const FormularioState();

  @override
  List<Object> get props => [];
}

final class FormularioInitialState extends FormularioState {}

class FormularioayudaLoad extends FormularioState {}

class FormularioayudaSuccess extends FormularioState {
  const FormularioayudaSuccess(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}

class FormularioayudaError extends FormularioState {
  const FormularioayudaError(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
