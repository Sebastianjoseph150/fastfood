// part of 'search_bloc.dart';

// abstract class SearchState extends Equatable {
//   const SearchState();

//   @override
//   List<Object> get props => [];

//   get restaurantSearchResults => null;
// }

// class SearchInitial extends SearchState {}

// class SearchLoading extends SearchState {}

// class SearchSuccess extends SearchState {

//   final List<Restaurant> restaurantSearchResults;
//   final List<FeaturedDish> featuredResult;
//   final String selectedOption;

//   SearchSuccess(
//       {required this.restaurantSearchResults,
//       required this.selectedOption,
//       required this.featuredResult});

//   @override
//   List<Object> get props =>
//       [restaurantSearchResults, selectedOption, featuredResult];
// }

// class SearchError extends SearchState {
//   final String message;

//   SearchError(this.message);

//   @override
//   List<Object> get props => [message];

// }
// class Clearsearch extends SearchState
// {}
// search_state.dart
// search_state.dart

part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  // final List<Restaurant> allrestaurant;
  // final List<FeaturedDish> allfeaturediteams;

  // SearchInitial({required this.allrestaurant, required this.allfeaturediteams});
}

class liststate extends SearchState {
  final List<Restaurant> allrestaurant;
  final List<FeaturedDish> allfeaturediteams;

  const liststate({required this.allrestaurant, required this.allfeaturediteams});
}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Restaurant> restaurantSearchResults;
  final List<FeaturedDish> featuredResult;
  final String selectedOption;

  const SearchSuccess({
    required this.restaurantSearchResults,
    required this.selectedOption,
    required this.featuredResult,
  });

  @override
  List<Object> get props =>
      [restaurantSearchResults, selectedOption, featuredResult];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class Clearsearch extends SearchState {}


