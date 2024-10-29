part of 'ranking_bloc.dart';

sealed class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object> get props => [];
}

final class RankingInitialState extends RankingState {}

class RankingLoad extends RankingState {}

class RankingSuccess extends RankingState {
  const RankingSuccess(this.data);
  final Ranking data;
  @override
  List<Object> get props => [data];
}

class ErrorRanking extends RankingState {
  const ErrorRanking(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
