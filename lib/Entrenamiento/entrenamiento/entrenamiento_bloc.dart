// ignore_for_file: strict_raw_type

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/Entrenamiento/models/active_test_salida_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/leccion_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/models.dart';
import 'package:universidad_lg_24/Entrenamiento/models/respuestas_test_salida_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/send_test_entrada_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/send_test_salida_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/test_entrada_model.dart';
import 'package:universidad_lg_24/Entrenamiento/models/test_salida_model.dart';
import 'package:universidad_lg_24/Entrenamiento/services/entrenamiento_service.dart';

part 'entrenamiento_event.dart';
part 'entrenamiento_state.dart';

class EntrenamientoBloc extends Bloc<EntrenamientoEvent, EntrenamientoState> {
  EntrenamientoBloc() : super(EntrenamientoInitial()) {
    on<EntrenamientoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  EntrenamientoService entrenamientoService = EntrenamientoService();

  Future<EntrenamientoModel?> getEntrenamientoContent({
    String? token,
    String? uid,
  }) async {
    return entrenamientoService.servicegetEntrenamientoContent(
      uid!,
      token!,
    );
  }

  Future<CursoPreview?> getCursoPreviewContent({
    String? token,
    String? uid,
    String? curso,
  }) async {
    return await entrenamientoService.serviceGetCursoPreviewContent(
      uid!,
      token!,
      curso!,
    );
  }

  Future<TestEntrada?> getTestEntradaContent({
    String? token,
    String? uid,
    String? curso,
    String? leccion,
  }) async {
    return await entrenamientoService.serviceGetTestEntradaContent(
      uid!,
      token!,
      curso!,
      leccion!,
    );
  }

  Future<SendTestEntrada?> sendTestEntrada({
    String? token,
    String? uid,
    String? curso,
    String? leccion,
    Map? data,
  }) async {
    return await entrenamientoService.serviceSendTestEntrada(
      uid!,
      token!,
      curso!,
      leccion!,
      data!,
    );
  }

  Future<Leccion?> getLeccionContent({
    String? token,
    String? uid,
    String? curso,
    String? leccion,
  }) async {
    return await entrenamientoService.serviceGetLeccionContent(
      uid!,
      token!,
      curso!,
      leccion!,
    );
  }

  Future<ActiveTestSalida?> activeTestSalida({
    String? token,
    String? uid,
    String? curso,
  }) async {
    return await entrenamientoService.serviceActiveTestSalida(
      uid!,
      token!,
      curso!,
    );
  }

  Future<TestSalida?> getTestSalidaContent({
    String? token,
    String? uid,
    String? curso,
    String? leccion,
  }) async {
    return await entrenamientoService.serviceGetTestSalidaContent(
      uid!,
      token!,
      curso!,
      leccion!,
    );
  }

  Future<SendTestSalida?> sendTestSalida({
    String? token,
    String? uid,
    String? curso,
    String? leccion,
    Map? data,
  }) async {
    return await entrenamientoService.serviceSendTestSalida(
      uid!,
      token!,
      curso!,
      leccion!,
      data!,
    );
  }

  Future<RespuestasTestSalida> respuestasTestSalida({
    String? token,
    String? uid,
    String? curso,
  }) async {
    return await entrenamientoService.serviceRespuestasTestSalida(
      uid!,
      token!,
      curso!,
    );
  }
}
