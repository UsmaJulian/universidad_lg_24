part of 'register_bloc.dart';

@immutable
sealed class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

final class RegisterInitialState extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {}

final class RegisterFailureState extends RegisterState {
  RegisterFailureState({required this.error});
  final String error;

  @override
  List<Object> get props => [
        error,
      ];
}
