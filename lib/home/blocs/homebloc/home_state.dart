part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {}

class HomeFailureState extends HomeState {
  const HomeFailureState({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}
