part of 'fav_bloc.dart';

abstract class FavoriteEvent {}

class CheckFavorite extends FavoriteEvent {
  final String item;

  CheckFavorite(this.item);
}

class ToggleFavorite extends FavoriteEvent {
  final String item;
  final FeaturedDish dish;

  ToggleFavorite(this.item, this.dish);
}

class FetchFaviteams extends FavoriteEvent {}


