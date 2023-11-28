part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchRestaurants extends RestaurantEvent {}

class FetchProductsByRestaurant extends RestaurantEvent {
  final String restaurentname;
  FetchProductsByRestaurant({required this.restaurentname});
}
