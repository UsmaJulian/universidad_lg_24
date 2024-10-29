import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/users/exceptions/exceptions.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/services/services.dart';

part 'perfil_event.dart';
part 'perfil_state.dart';

class PerfilBloc extends Bloc<PerfilEvent, PerfilState> {
  PerfilBloc({required this.service}) : super(PerfilInitialState()) {
    on<GetPerfilEvent>((event, emit) async {
      try {
        emit(PerfilLoad());
        final data = await service.getPerfil(
          event.user.toString(),
          event.token.toString(),
        );

        emit(PerfilSuccess(data));
      } on PerfilException catch (e) {
        emit(ErrorPerfil(e.message));
      }
    });
    on<SetImagePerfilEvent>((event, emit) {
      try {
        emit(ChangeImage(event.path!));
      } on PerfilException catch (e) {
        emit(ErrorPerfil(e.message));
      }
    });
    on<SendPerfilEvent>((event, emit) async {
      try {
        emit(PerfilLoad());
        final message = await service.sentPerfil(
          event.user!,
          event.token!,
          event.documento!,
          event.celular!,
          event.imagen!,
        );
        emit(PerfilSend(message));
      } on PerfilException catch (e) {
        emit(ErrorPerfil(e.message));
      }
      try {
        final data = await service.getPerfil(event.user!, event.token!);
        emit(PerfilSuccess(data));
      } on PerfilException catch (e) {
        emit(ErrorPerfil(e.message));
      }
    });
  }
  final PerfilService service;
}
