part of 'featured_dish_bloc.dart';

abstract class FeaturedDishState extends Equatable {
  @override
  List<Object> get props => [];
}

class FeaturedDishInitial extends FeaturedDishState {}

class FeaturedDishLoading extends FeaturedDishState {}

class FeaturedDishLoaded extends FeaturedDishState {
  final List<FeaturedDish> featuredDishes;

  FeaturedDishLoaded(this.featuredDishes);

  @override
  List<Object> get props => [featuredDishes];
}

class FeaturedDishError extends FeaturedDishState {
  final String message;

  FeaturedDishError(this.message);

  @override
  List<Object> get props => [message];
}
