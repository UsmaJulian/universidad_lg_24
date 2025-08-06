part of 'ruleta_bloc.dart';

sealed class RuletaState extends Equatable {
  const RuletaState();

  @override
  List<Object> get props => [];
}

final class RuletaInitial extends RuletaState {}

class RuletaLoader extends RuletaState {
  @override
  List<Object> get props => [];
}

class RuletaSuccess extends RuletaState {
  const RuletaSuccess(this.data);
  final RuletaResponseModel data;

  @override
  List<Object> get props => [data];
}

class ErrorRuleta extends RuletaState {
  const ErrorRuleta(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
