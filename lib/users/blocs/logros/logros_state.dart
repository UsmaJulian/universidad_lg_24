part of 'logros_bloc.dart';

sealed class LogrosState extends Equatable {
  const LogrosState();

  @override
  List<Object> get props => [];
}

final class LogrosInitialState extends LogrosState {}

class LogrosLoad extends LogrosState {}

class LogrosSuccess extends LogrosState {
  const LogrosSuccess(this.data);
  final Logros data;
  @override
  List<Object> get props => [data];
}

class LogrosSearch extends LogrosState {
  const LogrosSearch(this.title);
  final String title;
  @override
  List<Object> get props => [title];
}

class ErrorLogros extends LogrosState {
  const ErrorLogros(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
