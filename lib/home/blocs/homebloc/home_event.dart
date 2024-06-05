part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeContentEvent extends HomeEvent {
  const GetHomeContentEvent({required this.uid, required this.token});
  final String uid;
  final String token;

  @override
  List<Object> get props => [uid, token];
}
