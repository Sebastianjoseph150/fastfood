import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:fastfood/screens/featured_detail/featured_detail.dart';
import 'package:fastfood/widgets/Featured_dish/featured_dish_card.dart';
import 'package:flutter/material.dart';

class FeaturedDishPage extends StatelessWidget {
  final List<FeaturedDish> featuredDish;

  const FeaturedDishPage({required this.featuredDish, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Featured Dishes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7,
        ),
        itemCount: featuredDish.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FeaturedDishDetailPage(
                            featuredDish: featuredDish[index])));
              },
              child: FeaturedDishCard(featuredDish: featuredDish[index]));
        },
      ),
    );
  }
}
