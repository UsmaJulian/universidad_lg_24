part of 'logros_bloc.dart';

sealed class LogrosEvent extends Equatable {
  const LogrosEvent();

  @override
  List<Object> get props => [];
}

class GetLogrosEvent extends LogrosEvent {
  const GetLogrosEvent(this.user, this.token);
  final String user;
  final String token;

  @override
  List<Object> get props => [user, token];
}

class SearchLogrosEvent extends LogrosEvent {
  const SearchLogrosEvent(this.titulo);
  final String titulo;
  @override
  List<Object> get props => [titulo];
}
