import 'package:fastfood/bloc/restauant/bloc/restaurant_bloc.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:fastfood/widgets/menu/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuPage extends StatelessWidget {
  final String restaurant;

  const MenuPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Menu for $restaurant"),
      ),
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (context, state) {
          if (state is ProductsByRestaurantLoaded) {
            List<FeaturedDish> products = state.restaurentiteams;
            List<FeaturedDish> productsForRestaurant = products
                .where((product) =>
                    product.restaurant.toLowerCase() ==
                    restaurant.toLowerCase())
                .toList();

            if (productsForRestaurant.isEmpty) {
              return Center(
                child: Text('No products available for $restaurant.'),
              );
            }

            return ListView.builder(
              itemCount: productsForRestaurant.length,
              itemBuilder: (context, index) {
                return MenuItemWidget(
                  itemrest: productsForRestaurant[index].restaurant,
                  itemid: productsForRestaurant[index].id,
                  itemcat: productsForRestaurant[index].category,
                  itemName: productsForRestaurant[index].name,
                  itemDescription: productsForRestaurant[index].description,
                  itemPrice: productsForRestaurant[index].price,
                  itemImage: productsForRestaurant[index].imageUrl,
                  // iteamquantity: productsForRestaurant[index].quantity,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Tapped on an item"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  onAddToCart: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to Cart"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is RestaurantLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RestaurantError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
