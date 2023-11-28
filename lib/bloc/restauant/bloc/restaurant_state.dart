part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

class RestaurantLoading extends RestaurantState {}

class RestaurantMenuLoading extends RestaurantState {}

class RestaurantLoaded extends RestaurantState {
  final List<Restaurant> restaurants;

  RestaurantLoaded(this.restaurants);

  @override
  List<Object> get props => [restaurants];
}

// ignore: must_be_immutable
class ProductsByRestaurantLoaded extends RestaurantState {
  List<FeaturedDish> restaurentiteams;

  ProductsByRestaurantLoaded(this.restaurentiteams);

  @override
  List<Object> get props => [restaurentiteams];
}

class RestaurantError extends RestaurantState {
  final String message;

  RestaurantError(this.message);

  @override
  List<Object> get props => [message];
}
