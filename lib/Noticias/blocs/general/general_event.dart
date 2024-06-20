part of 'general_bloc.dart';

sealed class GeneralEvent extends Equatable {
  const GeneralEvent();

  @override
  List<Object> get props => [];
}

class GetNoticiasEvent extends GeneralEvent {
  const GetNoticiasEvent({this.user, this.token});
  final String? user;
  final String? token;
  @override
  List<Object> get props => [user!, token!];
}
