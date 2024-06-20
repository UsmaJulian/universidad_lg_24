import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/Noticias/exceptions/exception.dart';
import 'package:universidad_lg_24/Noticias/models/models.dart';
import 'package:universidad_lg_24/Noticias/services/services.dart';

part 'general_event.dart';
part 'general_state.dart';

class GeneralBloc extends Bloc<GeneralEvent, GeneralState> {
  GeneralBloc({required this.service}) : super(GeneralInitialState()) {
    on<GetNoticiasEvent>((event, emit) async {
      emit(GeneralLoading());
      try {
        final data = await service.getNoticiasData(
          token: event.token.toString(),
          userid: event.user.toString(),
        );
        emit(GeneralSuccess(data));
      } on NoticiasException catch (e) {
        emit(ErrorGeneralNoticias(e.message));
      }
    });
  }
  final NoticiasService service;
}
