part of 'ayuda_bloc.dart';

sealed class AyudaEvent extends Equatable {
  const AyudaEvent();

  @override
  List<Object> get props => [];
}

class GetAyudaEvent extends AyudaEvent {
  const GetAyudaEvent({required this.user, required this.token});
  final User user;
  final String token;

  @override
  List<Object> get props => [user, token];
}
