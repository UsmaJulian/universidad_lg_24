import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/users/exceptions/exceptions.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/services/logros_services.dart';

part 'logros_event.dart';
part 'logros_state.dart';

class LogrosBloc extends Bloc<LogrosEvent, LogrosState> {
  LogrosBloc({required this.service}) : super(LogrosInitialState()) {
    on<GetLogrosEvent>((event, emit) async {
      try {
        emit(LogrosLoad());
        final data = await service.getLogros(event.user, event.token);
        emit(LogrosSuccess(data));
      } on LogrosException catch (e) {
        emit(ErrorLogros(e.message));
      }
    });
    on<SearchLogrosEvent>((event, emit) {
      try {
        emit(LogrosLoad());
        emit(LogrosSearch(event.titulo));
      } on LogrosException catch (e) {
        emit(ErrorLogros(e.message));
      }
    });
  }
  final LogrosService service;
}
