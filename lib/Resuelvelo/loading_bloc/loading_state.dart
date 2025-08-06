part of 'loading_bloc.dart';

class LoadingState extends Equatable {
  const LoadingState({required this.isLoading});
  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];
}
