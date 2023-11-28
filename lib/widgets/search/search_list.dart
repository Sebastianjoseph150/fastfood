// ignore_for_file: use_key_in_widget_constructors
import 'package:fastfood/bloc/search/bloc/search_bloc.dart';
import 'package:fastfood/models/usermodel/Restaurent/restaurent.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:fastfood/repository/FeaturedDishesRepository/featured_Dishes_Repo.dart';
import 'package:fastfood/repository/restaurent%20iteams/reastaurent_iteams_repo.dart';
import 'package:fastfood/screens/featured_detail/featured_detail.dart';
import 'package:fastfood/widgets/Featured_dish/featured_dish_card.dart';
import 'package:fastfood/widgets/Restaurent_card/restaurent_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const CircularProgressIndicator();
          } else if (state is SearchSuccess) {
            List<Restaurant> restaurants = state.restaurantSearchResults;
            List<FeaturedDish> featuredDishes = state.featuredResult;

            if (state is SearchInitial) {
              RestaurentRepo().fetchAllRestaurants();
              FeaturedDishesRepository().fetchUserProducts();
              // Display all restaurants and featured dishes when in initial state
              restaurants = RestaurentRepo().allRestaurants;

              featuredDishes =
                  FeaturedDishesRepository().allUsersFeaturedDishes;
              // final allfeatured = FeaturedDishesRepository().allUsersFeaturedDishes;
              // final allrestaurant = RestaurentRepo().allRestaurants;
              // context.read<SearchBloc>().add(listevent(allfeaturediteams: ));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                Expanded(
                  child: buildResultsList(
                    state.selectedOption,
                    restaurants,
                    featuredDishes,
                  ),
                ),
              ],
            );
          } else if (state is SearchError) {
            return Text('Error: ${state.message}');
          } else if (state is ClearSearch) {
            // Clear the search results when ClearSearch event is dispatched
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget buildResultsList(
    String selectedOption,
    List<Restaurant> restaurants,
    List<FeaturedDish> featuredDishes,
  ) {
    if (selectedOption == 'Restaurant') {
      return ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return RestaurantCard(
            restaurant: restaurants[index],
          );
        },
      );
    } else if (selectedOption == 'Dishes') {
      return ListView.builder(
        itemCount: featuredDishes.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeaturedDishDetailPage(
                    featuredDish: featuredDishes[index],
                  ),
                ),
              );
            },
            child: FeaturedDishCard(featuredDish: featuredDishes[index]),
          );
        },
      );
    } else {
      return Container(); // You can customize this as needed
    }
  }
}
