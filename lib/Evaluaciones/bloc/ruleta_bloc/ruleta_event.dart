part of 'ruleta_bloc.dart';

sealed class RuletaEvent extends Equatable {
  const RuletaEvent();

  @override
  List<Object> get props => [];
}

class GetRuletaEvent extends RuletaEvent {
  const GetRuletaEvent({
    required this.userId,
    required this.token,
  });
  final String userId;
  final String token;

  @override
  List<Object> get props => [userId, token];
}
