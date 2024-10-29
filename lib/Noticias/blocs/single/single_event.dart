part of 'single_bloc.dart';

sealed class SingleEvent extends Equatable {
  const SingleEvent();

  @override
  List<Object> get props => [];
}

class GetSingleNoticiaEvent extends SingleEvent {
  const GetSingleNoticiaEvent({this.user, this.token, this.nid});
  final String? user;
  final String? token;
  final String? nid;

  @override
  List<Object> get props => [user!, token!, nid!];
}
