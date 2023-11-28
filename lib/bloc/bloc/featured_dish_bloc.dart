import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:fastfood/repository/FeaturedDishesRepository/featured_Dishes_Repo.dart';

part 'featured_dish_state.dart';
part 'featured_dish_event.dart';

class FeaturedDishesBloc extends Bloc<FeaturedDishEvent, FeaturedDishState> {
  final FeaturedDishesRepository featuredDishesRepository;
  // final User currentUser; // Add a field for the current user

  FeaturedDishesBloc({required this.featuredDishesRepository})
      : super(FeaturedDishInitial()) {
    on<FetchFeaturedDishes>(_fetchFeaturedDishes);
  }

  void _fetchFeaturedDishes(
    FetchFeaturedDishes event,
    Emitter<FeaturedDishState> emit,
  ) async {
    emit(FeaturedDishLoading());

    try {
      final featuredDishes = await featuredDishesRepository.fetchUserProducts();
      if (featuredDishes.isNotEmpty) {
        emit(FeaturedDishLoaded(featuredDishes));
      } else {
        emit(FeaturedDishError("No featured dishes available"));
      }
    } catch (e) {
      emit(FeaturedDishError("Failed to load featured dishes: $e"));
    }
  }
}
