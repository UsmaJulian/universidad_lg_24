import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/Ranking/exception/ranking_exception.dart';
import 'package:universidad_lg_24/Ranking/models/ranking_model.dart';
import 'package:universidad_lg_24/Ranking/services/ranking_services.dart';

part 'ranking_event.dart';
part 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  RankingBloc({required this.service}) : super(RankingInitialState()) {
    on<GetRanking>((event, emit) async {
      try {
        emit(RankingLoad());
        final data = await service.getRankingService(
          uid: event.user,
          token: event.token,
        );
        emit(RankingSuccess(data));
      } on RankingException catch (e) {
        emit(ErrorRanking(e.message));
      }
    });
  }
  final RankingService service;
}
