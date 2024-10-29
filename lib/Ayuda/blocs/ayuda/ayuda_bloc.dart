import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/Ayuda/exception/ayuda_exception.dart';
import 'package:universidad_lg_24/Ayuda/models/ayuda_model.dart';
import 'package:universidad_lg_24/Ayuda/services/ayuda_service.dart';
import 'package:universidad_lg_24/users/models/models.dart';

part 'ayuda_event.dart';
part 'ayuda_state.dart';

class AyudaBloc extends Bloc<AyudaEvent, AyudaState> {
  AyudaBloc({required this.service}) : super(AyudaInitialState()) {
    on<GetAyudaEvent>((event, emit) async {
      try {
        emit(AyudaLoader());
        final data = await service.getAyuda(
          user: event.user.toString(),
          token: event.token,
        );
        emit(AyudaSuccess(data));
      } on AyudaException catch (e) {
        emit(ErrorAyuda(e.mesaje));
      }
    });
  }
  final AyudaService service;
}
