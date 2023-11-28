// search_bloc.dart

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastfood/models/usermodel/Restaurent/restaurent.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:fastfood/repository/FeaturedDishesRepository/featured_Dishes_Repo.dart';
import 'package:fastfood/repository/restaurent%20iteams/reastaurent_iteams_repo.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final RestaurentRepo restaurentRepo;
  final FeaturedDishesRepository featuredDishesRepository;
  List<Restaurant> restaurantSearchResults = [];
  List<FeaturedDish> featuredResult = [];

  SearchBloc(this.restaurentRepo, this.featuredDishesRepository)
      : super(SearchInitial()) {
    on<SearchInitialEvent>(searchInitialEvent);
    on<PerformSearch>(_performSearch);
    on<ClearSearch>(_clearSearch);
    on<listevent>(_liststate);
  }

  Future<void> _performSearch(
      PerformSearch event, Emitter<SearchState> emit) async {
    emit(SearchLoading());

    try {
      if (event.selectedOption == 'Restaurant') {
        restaurantSearchResults = restaurentRepo.searchRestaurants(event.query);

        emit(SearchSuccess(
          restaurantSearchResults: restaurantSearchResults,
          selectedOption: event.selectedOption,
          featuredResult: const [],
        ));
      } else if (event.selectedOption == 'Dishes') {
        List<FeaturedDish> searchResults =
            featuredDishesRepository.searchFeaturedDishes(event.query);
        featuredResult = featuredDishesRepository.featuredListSearchResult;

        emit(SearchSuccess(
          restaurantSearchResults: const [],
          selectedOption: event.selectedOption,
          featuredResult: searchResults,
        ));
      }
    } catch (e) {
      emit(const SearchError('An error occurred during search'));
    }
  }

  FutureOr<void> _clearSearch(
      ClearSearch event, Emitter<SearchState> emit) async {
    restaurantSearchResults.clear();
    emit(SearchInitial());
    // emit(liststate(
    //     allfeaturediteams: allfeaturediteam, allrestaurant: allrestaurant));
  }

  FutureOr<void> searchInitialEvent(
      SearchInitialEvent event, Emitter<SearchState> emit) {
    try {} catch (e) {}
  }

  FutureOr<void> _liststate(listevent event, Emitter<SearchState> emit) {
    try {
      emit(liststate(
          allrestaurant: event.allrestaurant,
          allfeaturediteams: event.allfeaturediteams));
    } catch (e) {}
  }
}
