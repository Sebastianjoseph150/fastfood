import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:fastfood/repository/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  CategoryBloc({required this.categoryRepository})
      : super(CategoryInitialState()) {
    on<FetchCategoryProducts>(fetchCategoryProducts);
    on<NavigateToProductList>(navigateToProductList);
  }

  FutureOr<void> fetchCategoryProducts(
      FetchCategoryProducts event, Emitter<CategoryState> emit) async {
    try {
      emit(CategoryLoadingState());

      final products =
          await categoryRepository.fetchUserProductsByCategory(event.category);

      emit(CategoryLoadedState(products));
    } catch (e) {
      // Handle errors and emit an error state
      emit(CategoryErrorState('Error fetching products: $e.toString()'));
    }
  }

  Future<void> navigateToProductList(
      NavigateToProductList event, Emitter<CategoryState> emit) async {
    emit(NavigateToProductListState(event.products));
  }
}
