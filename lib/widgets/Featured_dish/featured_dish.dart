import 'package:fastfood/bloc/bloc/featured_dish_bloc.dart';
import 'package:fastfood/screens/featured_detail/featured_detail.dart';
import 'package:fastfood/screens/featured_dish_page/featured_dish_page.dart';
import 'package:fastfood/widgets/Featured_dish/featured_dish_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class FeaturedDishCardsList extends StatelessWidget {
  const FeaturedDishCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedDishesBloc, FeaturedDishState>(
      builder: (context, state) {
        if (state is FeaturedDishLoaded) {
          final featuredDishes = state.featuredDishes;

          if (featuredDishes.isNotEmpty) {
            return SizedBox(
              width: 500,
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...featuredDishes
                        .take(10)
                        .map(
                          (featuredDish) => Container(
                            height: 600,
                            width: 170,
                            margin: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FeaturedDishDetailPage(
                                      featuredDish: featuredDish,
                                    ),
                                  ),
                                );
                              },
                              child: FeaturedDishCard(
                                featuredDish: featuredDish,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    if (featuredDishes.length > 5)
                      TextButton(
                        onPressed: () {
                          // final FeaturedDish singleFeaturedDish = featuredDishes[
                          //     5]; // Choose the first remaining dish or apply specific logic to determine the FeaturedDish
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeaturedDishPage(
                                featuredDish: featuredDishes,
                              ),
                            ),
                          );
                        },
                        child: const Text('See More'),
                      ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('No featured dishes available');
          }
        } else if (state is FeaturedDishLoading) {
          return
              // Center(child: CircularProgressIndicator());
              Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    5, // Change this to the number of shimmer items you want
                itemBuilder: (context, index) {
                  return Container(
                    width: 170,
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
        } else {
          return const Text('Failed to load featured dishes');
        }
      },
    );
  }
}
