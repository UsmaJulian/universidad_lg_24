import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/Ayuda/blocs/ayuda/ayuda_bloc.dart';
import 'package:universidad_lg_24/Ayuda/services/services.dart';

part 'formulario_event.dart';
part 'formulario_state.dart';

class FormularioBloc extends Bloc<FormularioEvent, FormularioState> {
  FormularioBloc({required this.service}) : super(FormularioInitialState()) {
    on<SendFormularioAyudaEvent>((event, emit) async {
      try {
        emit(FormularioayudaLoad());
        final message = await service.sendFormAyuda(
          user: event.user,
          token: event.token,
          tema: event.tema,
          pregunta: event.pregunta,
        );
        emit(FormularioayudaSuccess(message));
      } on ErrorAyuda catch (e) {
        emit(FormularioayudaError(e.message));
      }
    });
  }
  final FormAyudaService service;
}
