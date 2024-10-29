part of 'entrenamiento_bloc.dart';

sealed class EntrenamientoState extends Equatable {
  const EntrenamientoState();
  
  @override
  List<Object> get props => [];
}

final class EntrenamientoInitial extends EntrenamientoState {}
