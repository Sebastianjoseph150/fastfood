part of 'category_bloc.dart';

abstract class CategoryEvent {}

class FetchCategoryProducts extends CategoryEvent {
  final String category;

  FetchCategoryProducts(this.category);
}
class CatPressedEvent extends CategoryEvent{}

class NavigateToProductList extends CategoryEvent {
  final List<FeaturedDish> products;

  NavigateToProductList(this.products);
}
