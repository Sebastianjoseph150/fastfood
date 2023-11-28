part of 'fav_bloc.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final bool isFavorite;

  FavoriteLoaded(this.isFavorite);
}

class FavIteamFetching extends FavoriteState {}

class FavIteamsFetched extends FavoriteState {
  final List<FeaturedDish> fetchediteams;

  FavIteamsFetched({required this.fetchediteams});
}
