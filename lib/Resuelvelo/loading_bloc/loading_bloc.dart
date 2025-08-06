import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_event.dart';
part 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(const LoadingState(isLoading: false)) {
    on<ShowLoading>((event, emit) => emit(const LoadingState(isLoading: true)));
    on<HideLoading>(
      (event, emit) => emit(const LoadingState(isLoading: false)),
    );
  }
}
