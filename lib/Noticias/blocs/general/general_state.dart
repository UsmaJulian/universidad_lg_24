part of 'general_bloc.dart';

sealed class GeneralState extends Equatable {
  const GeneralState();

  @override
  List<Object> get props => [];
}

final class GeneralInitialState extends GeneralState {}

class GeneralLoading extends GeneralState {}

class GeneralSuccess extends GeneralState {
  const GeneralSuccess(this.data);
  // el estado que es  intanciado  por el bloc y consultado en   pagina
  final Noticias data;
  @override
  List<Object> get props => [data];
}

class ErrorGeneralNoticias extends GeneralState {
  const ErrorGeneralNoticias(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
