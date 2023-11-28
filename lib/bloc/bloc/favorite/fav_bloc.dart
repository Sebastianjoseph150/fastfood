// import 'dart:async';

// import 'package:fastfood/models/usermodel/featured_dish.dart';
// import 'package:fastfood/repository/favorite/favorite_repo.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'fav_event.dart';
// part 'fav_state.dart';

// class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
//   final FavoriteRepository favoriteRepository;

//   FavoriteBloc({required this.favoriteRepository}) : super(FavoriteInitial()) {
//     on<CheckFavorite>(checkFavorite);
//     on<ToggleFavorite>(toggleFavorite);
//     on<FetchFaviteams>(fetchFaviteams);
//   }

//   FutureOr<void> checkFavorite(
//       CheckFavorite event, Emitter<FavoriteState> emit) async {
//     emit(FavoriteLoading());
//     final isFavorite = await favoriteRepository.isFavorite(event.item);
//     emit(FavoriteLoaded(isFavorite));
//   }

//   FutureOr<void> toggleFavorite(
//       ToggleFavorite event, Emitter<FavoriteState> emit) async {
//     final isFavorite = await favoriteRepository.isFavorite(event.item);
//     if (isFavorite) {
//       await favoriteRepository.removeFromFavorites(event.item);
//     } else {
//       await favoriteRepository.addToFavorites(event.item, event.dish);
//     }
//     emit(FavoriteLoaded(!isFavorite));
//   }

//   FutureOr<void> fetchFaviteams(
//       FetchFaviteams event, Emitter<FavoriteState> emit) {
//     emit(favIteamFetching());
//     final FeaturedDish fetchediteam =
//         favoriteRepository.fetchAllFavoriteItems();
//   }
// }
import 'dart:async';

import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:fastfood/repository/favorite/favorite_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc({required this.favoriteRepository}) : super(FavoriteInitial()) {
    on<CheckFavorite>(checkFavorite);
    on<ToggleFavorite>(toggleFavorite);
    on<FetchFaviteams>(fetchFaviteams);
  }

  Future<void> checkFavorite(
      CheckFavorite event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());
    final isFavorite = await favoriteRepository.isFavorite(event.item);
    emit(FavoriteLoaded(isFavorite));
  }

  Future<void> toggleFavorite(
      ToggleFavorite event, Emitter<FavoriteState> emit) async {
    final isFavorite = await favoriteRepository.isFavorite(event.item);
    if (isFavorite) {
      await favoriteRepository.removeFromFavorites(event.item);
      // add(FetchFaviteams());
    } else {
      await favoriteRepository.addToFavorites(event.item, event.dish);
      // add(FetchFaviteams());
    }
    add(FetchFaviteams());
    emit(FavoriteLoaded(!isFavorite));
  }

  Future<void> fetchFaviteams(
      FetchFaviteams event, Emitter<FavoriteState> emit) async {
    emit(FavIteamFetching());
    try {
      final List<Map<String, dynamic>> favoriteItems =
          await favoriteRepository.fetchAllFavoriteItems();

      final List<FeaturedDish> featuredDishes =
          favoriteItems.map((data) => FeaturedDish.fromMap(data)).toList();

      emit(FavIteamsFetched(fetchediteams: featuredDishes));
    } catch (e) {
      // Handle the error here, for example:
      // emit(FavIteamsFetchError(errorMessage: e.toString()));
    }
  }
}
