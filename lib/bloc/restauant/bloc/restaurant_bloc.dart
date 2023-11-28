import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastfood/models/usermodel/Restaurent/restaurent.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:fastfood/repository/restaurent%20iteams/reastaurent_iteams_repo.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurentRepo restaurentRepo;

  RestaurantBloc({required this.restaurentRepo}) : super(RestaurantInitial()) {
    on<FetchRestaurants>(_fetchRestaurants);
    on<FetchProductsByRestaurant>(_fetchProductsByRestaurant);
  }

  Future<void> _fetchRestaurants(
      FetchRestaurants event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      List<Restaurant> restaurants = await restaurentRepo.fetchAllRestaurants();
      emit(RestaurantLoaded(restaurants));
    } catch (e) {
      emit(RestaurantError('Error fetching restaurants'));
    }
  }

  Future<void> _fetchProductsByRestaurant(
      FetchProductsByRestaurant event, Emitter<RestaurantState> emit) async {
    emit(RestaurantMenuLoading());
    try {
      List<FeaturedDish> products =
          await restaurentRepo.fetchProductsForRestaurant(event.restaurentname);
      emit(ProductsByRestaurantLoaded(products));
    } catch (e) {
      emit(RestaurantError('Error fetching products by restaurant'));
    }
  }
}
