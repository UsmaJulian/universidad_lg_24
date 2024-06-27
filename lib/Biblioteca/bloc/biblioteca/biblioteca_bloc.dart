import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/Biblioteca/exception/exception.dart';
import 'package:universidad_lg_24/Biblioteca/models/biblioteca_model.dart';
import 'package:universidad_lg_24/Biblioteca/services/biblioteca_services.dart';

part 'biblioteca_event.dart';
part 'biblioteca_state.dart';

class BibliotecaBloc extends Bloc<BibliotecaEvent, BibliotecaState> {
  BibliotecaBloc({required this.service}) : super(BibliotecaInitialState()) {
    on<GetBibliotecaEvent>((event, emit) async {
      try {
        emit(BibliotecaLoad());
        final data =
            await service.getBiblioteca(userid: event.user, token: event.token);
        emit(BibliotecaSucess(data));
      } on BibliotecaException catch (e) {
        emit(ErrorBiblioteca(e.message));
      }
    });
    on<FiterBibliotecaEvent>(
      (event, emit) {
        try {
          final filtro = event.filtro.toString();
          emit(BibliotecaChangeFilter(filtro));
        } on BibliotecaException catch (e) {
          emit(ErrorBiblioteca(e.message));
        }
      },
    );
    on<CategoriaBibliotecaEvent>(
      (event, emit) {
        try {
          final categoria = event.categoria.toString();
          emit(BibliotecaChangeCategoria(categoria));
        } on BibliotecaException catch (e) {
          emit(ErrorBiblioteca(e.message));
        }
      },
    );
  }
  final BibliotecaService service;
}
