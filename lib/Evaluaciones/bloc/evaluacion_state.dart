part of 'evaluacion_bloc.dart';

sealed class EvaluacionState extends Equatable {
  const EvaluacionState();
  
  @override
  List<Object> get props => [];
}

final class EvaluacionInitial extends EvaluacionState {}
