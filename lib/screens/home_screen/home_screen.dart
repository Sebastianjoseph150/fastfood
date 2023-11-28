import 'package:fastfood/bloc/bloc/featured_dish_bloc.dart';
import 'package:fastfood/bloc/restauant/bloc/restaurant_bloc.dart';
import 'package:fastfood/widgets/Featured_dish/featured_dish.dart';
import 'package:fastfood/widgets/Restaurent_card/restaurent_card.dart';
import 'package:fastfood/widgets/banner/banner_widget.dart';
import 'package:fastfood/widgets/category/category_listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    final featuredDishesBloc = BlocProvider.of<FeaturedDishesBloc>(context);
    // final restaurantBloc = BlocProvider.of<RestaurantBloc>(context);
    // restaurantBloc.add(FetchRestaurants());

    featuredDishesBloc.add(FetchFeaturedDishes());
  }

  @override
  Widget build(BuildContext context) {
    context.read<RestaurantBloc>().add(FetchRestaurants());
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<RestaurantBloc, RestaurantState>(
        listener: (context, state) {
          if (state is RestaurantLoaded) {
            // Handle loaded state if needed
          } else if (state is RestaurantError) {
            // Handle error state if needed
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              BannerWidget(),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Whats on your mind ?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CategoryListing(),

              BlocBuilder<RestaurantBloc, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantLoaded) {
                    final restaurants = state.restaurants;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                          child: Text(
                            'Popular Restaurants',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 300,
                                child: RestaurantCard(
                                  restaurant: restaurants[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is RestaurantLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 300,
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (state is RestaurantError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return Container();
                  }
                },
              ),
              // buildPopularRestaurants(context),

              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Featured Dishes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const FeaturedDishCardsList(),
            ],
          ),
        ),
      ),
    );
  }
}
