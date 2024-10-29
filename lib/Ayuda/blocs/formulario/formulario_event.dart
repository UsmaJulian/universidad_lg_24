part of 'formulario_bloc.dart';

sealed class FormularioEvent extends Equatable {
  const FormularioEvent();

  @override
  List<Object> get props => [];
}

class SendFormularioAyudaEvent extends FormularioEvent {
  const SendFormularioAyudaEvent({
    this.user,
    this.token,
    this.tema,
    this.pregunta,
  });
  final String? tema;
  final String? pregunta;
  final String? user;
  final String? token;
  @override
  List<Object> get props => [tema!, pregunta!, user!, token!];
}
