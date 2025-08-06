import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/Evaluaciones/models/ruleta_model.dart';
import 'package:universidad_lg_24/Evaluaciones/services/ruleta_services.dart';

part 'ruleta_event.dart';
part 'ruleta_state.dart';

class RuletaBloc extends Bloc<RuletaEvent, RuletaState> {
  RuletaBloc() : super(RuletaInitial()) {
    on<GetRuletaEvent>(_onGetRuleta);
  }
  RuletaServices ruletaservice = RuletaServices();

  FutureOr<void> _onGetRuleta(
    GetRuletaEvent event,
    Emitter<RuletaState> emit,
  ) async {
    try {
      log('RuletaBloc: Fetching content for userId: ${event.userId} with token: ${event.token}');
      final response =
          await ruletaservice.getRuletaContent(event.userId, event.token);
      log('Ruleta request: ${response.body?.listado}');
      if (response.response?.code == 200) {
        log('Ruleta status: ${response.response?.code}');
        emit(RuletaSuccess(response));
      }
    } catch (e) {
      emit(ErrorRuleta(e.toString()));
    }
  }
}
