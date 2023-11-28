import 'package:bloc/bloc.dart';
import 'package:fastfood/repository/nav_repository/nav_repository.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final NavRepo navRepo;

  NavigationBloc({required this.navRepo}) : super(NavigationInitial()) {
    on<NavigateToHomeEvent>((event, emit) {
      // Handle NavigateToHomeEvent and emit the corresponding state
      emit(HomeScreenState());
    });

    on<NavigateToProfileEvent>((event, emit) {
      // Handle NavigateToProfileEvent and emit the corresponding state
      emit(ProfileScreenState());
    });

    on<NavigateToSettingsEvent>((event, emit) {
      emit(SettingsScreenState());
    });
    on<NavigateToCartEvent>((event, emit) {
      emit(CartScreenState());
    });
  }
}
