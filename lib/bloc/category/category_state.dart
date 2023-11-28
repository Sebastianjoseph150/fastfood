part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {}

class CategoryInitialState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoadingState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoadedState extends CategoryState {
  final List<FeaturedDish> products;

  CategoryLoadedState(this.products);

  @override
  List<Object> get props => [];
}

class NavigateToProductListState extends CategoryState {
  final List<FeaturedDish> products;

  NavigateToProductListState(this.products);

  @override
  List<Object> get props => [products];
}

class CategoryErrorState extends CategoryState {
  final String error;
  CategoryErrorState(this.error);

  @override
  List<Object> get props => [];
}

class CategoryProductsLoaded extends CategoryState {
  @override
  List<Object> get props => [];
}
