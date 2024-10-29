import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/Noticias/exceptions/exception.dart';
import 'package:universidad_lg_24/Noticias/models/models.dart';
import 'package:universidad_lg_24/Noticias/services/services.dart';

part 'single_event.dart';
part 'single_state.dart';

class SingleBloc extends Bloc<SingleEvent, SingleState> {
  SingleBloc({required this.service}) : super(SingleInitialState()) {
    on<GetSingleNoticiaEvent>((event, emit) async {
      emit(SingleLoading());
      try {
        final data = await service.getSteamingSingleData(
          userid: event.user.toString(),
          token: event.token.toString(),
          nid: event.nid.toString(),
        );
        emit(SingleSuccess(data));
      } on NoticiasException catch (e) {
        emit(ErrorSingle(e.message));
      }
    });
  }
  final ServiceNoticiasSingle service;
}
