import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:universidad_lg_24/home/models/models.dart';
import 'package:universidad_lg_24/home/services/home_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  HomeService homeService = HomeService();
  Future<HomeModel> getHomeContent({String? token, String? uid}) async {
    return await homeService.servicegetHomeContent(uid!, token!);
  }
}
