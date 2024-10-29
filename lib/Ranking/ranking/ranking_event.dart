part of 'ranking_bloc.dart';

sealed class RankingEvent extends Equatable {
  const RankingEvent();

  @override
  List<Object> get props => [];
}

class GetRanking extends RankingEvent {
  const GetRanking(this.user, this.token);
  final String user;
  final String token;

  @override
  List<Object> get props => [user, token];
}
