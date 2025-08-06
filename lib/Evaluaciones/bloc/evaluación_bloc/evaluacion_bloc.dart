import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/Evaluaciones/models/models.dart';
import 'package:universidad_lg_24/Evaluaciones/services/evaluacion_service.dart';

part 'evaluacion_event.dart';
part 'evaluacion_state.dart';

class EvaluacionBloc extends Bloc<EvaluacionEvent, EvaluacionState> {
  EvaluacionBloc() : super(EvaluacionInitial()) {
    on<EvaluacionEvent>((event, emit) {});
  }
  EvaluacionService entrenamintoService = EvaluacionService();

  Future<Evaluacion> getEvaluaionesContent({String? token, String? uid}) async {
    return await entrenamintoService.servicegetEvaluacionesContent(
      uid!,
      token!,
    );
  }

  Future<SingleEvaluacion> getSingleEvaluaionesContent({
    String? token,
    String? uid,
    String? nid,
  }) async {
    return await entrenamintoService.servicegetSingleEvaluacionesContent(
      uid!,
      token!,
      nid!,
    );
  }

  Future<SendEvaluacion> sendEvaluacion({
    String? token,
    String? uid,
    String? nid,
    Map<dynamic, dynamic>? data,
  }) async {
    return await entrenamintoService.sendEvaluacion(uid, token, nid, data!);
  }

  Future<RespuestaEvaluacion> getResultados({
    String? token,
    String? uid,
    String? nid,
  }) async {
    return await entrenamintoService.getResultados(uid!, token!, nid!);
  }
}
