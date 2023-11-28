import 'dart:convert';

import 'package:fastfood/bloc/cart/bloc/cart_bloc.dart';
import 'package:fastfood/models/usermodel/cart_Items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFAB extends StatelessWidget {
  final String restaurant;

  const MyFAB({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.menu_book),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final String itemid;
  final String itemcat;
  final String itemrest;
  final String itemName;
  final String itemDescription;
  final String itemPrice;
  final String itemImage;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const MenuItemWidget({
    super.key,
    required this.itemName,
    required this.itemDescription,
    required this.itemPrice,
    required this.itemImage,
    this.onTap,
    this.onAddToCart,
    required this.itemid,
    required this.itemcat,
    required this.itemrest,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(base64Decode(itemImage)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  itemDescription,
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ $itemPrice',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    BlocListener<CartBloc, CartState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          CartItem addtocart = CartItem(
                              itemId: itemid,
                              name: itemName,
                              price: double.parse(itemPrice),
                              description: itemDescription,
                              quantity: 0,
                              imagepath: itemImage,
                              restaurant: itemrest);
                          if (onAddToCart != null) {
                            onAddToCart!();
                            context
                                .read<CartBloc>()
                                .add(AddToCartEvent(addtocart));
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                        ),
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
