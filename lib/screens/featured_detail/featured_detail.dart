import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/bloc/cart/bloc/cart_bloc.dart';
import 'package:fastfood/models/usermodel/cart_Items.dart';
import 'package:fastfood/widgets/favorite_wiget/favorite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedDishDetailPage extends StatelessWidget {
  final FeaturedDish featuredDish;

  const FeaturedDishDetailPage({super.key, required this.featuredDish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Dish Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 500,
                  child: Card(
                    elevation: 10,
                    child: Image.memory(
                      base64Decode(featuredDish.imageUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      featuredDish.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Price: ₹${featuredDish.price.toString()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                Text(
                  ' ${featuredDish.restaurant}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  featuredDish.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: BlocListener<CartBloc, CartState>(
                    listener: (context, state) {
                      if (state is AddedToCart) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to Cart!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            CartItem cartItem = CartItem(
                              itemId: featuredDish.id, // Setting the itemId
                              quantity: 0,
                              imagepath: featuredDish.imageUrl,
                              name: featuredDish.name,
                              description: featuredDish.description,
                              price: double.parse(featuredDish.price),
                              restaurant: featuredDish.restaurant,
                            );

                            // Get the current user's ID
                            final userId =
                                FirebaseAuth.instance.currentUser?.uid;

                            // Create a reference to the cart item document with the same ID as the featuredDish
                            final cartItemRef = FirebaseFirestore.instance
                                .collection('users')
                                .doc(userId)
                                .collection('cartitems')
                                .doc(featuredDish.id);

                            // Set the cart item data to Firestore
                            cartItemRef.set(cartItem.toMap()).then((value) {
                              context
                                  .read<CartBloc>()
                                  .add(AddToCartEvent(cartItem));
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                                color: Colors.white), // Set text color to white
                          ),
                        );
                      },
                    ),
                  ),
                ),
                FavoriteButton(item: featuredDish.id, dish: featuredDish),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
