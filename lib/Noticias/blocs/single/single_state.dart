part of 'single_bloc.dart';

sealed class SingleState extends Equatable {
  const SingleState();

  @override
  List<Object> get props => [];
}

final class SingleInitialState extends SingleState {}

class SingleLoading extends SingleState {}

class SingleSuccess extends SingleState {
  const SingleSuccess(this.data);
  final SingleNoticia data;
  @override
  List<Object> get props => [data];
}

class ErrorSingle extends SingleState {
  const ErrorSingle(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
