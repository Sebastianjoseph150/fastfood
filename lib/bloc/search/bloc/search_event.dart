// // search_event.dart

// part of 'search_bloc.dart';

// abstract class SearchEvent extends Equatable {
//   const SearchEvent();

//   @override
//   List<Object> get props => [];
// }

// class PerformSearch extends SearchEvent {
//   final String query;
//   final String selectedOption;

//   PerformSearch({required this.query, required this.selectedOption});

//   @override
//   List<Object> get props => [query, selectedOption];
// }

// class ClearSearch extends SearchEvent {}
// search_event.dart

part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class PerformSearch extends SearchEvent {
  final String query;
  final String selectedOption;

  const PerformSearch({
    required this.query,
    required this.selectedOption,
  });

  @override
  List<Object> get props => [query, selectedOption];
}

class ClearSearch extends SearchEvent {}

class SearchInitialEvent extends SearchEvent {
  final List<Restaurant> allrestaurant;
  final List<FeaturedDish> allfeaturediteams;

  const SearchInitialEvent(
      {required this.allrestaurant, required this.allfeaturediteams});
}

class listevent extends SearchEvent {
  final List<Restaurant> allrestaurant;
  final List<FeaturedDish> allfeaturediteams;

  const listevent({required this.allrestaurant, required this.allfeaturediteams});
}