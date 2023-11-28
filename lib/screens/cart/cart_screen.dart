import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/bloc/Address/bloc/address_bloc.dart';
import 'package:fastfood/models/usermodel/cart_Items.dart';
import 'package:fastfood/screens/address_screen/address_lising%20.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood/bloc/cart/bloc/cart_bloc.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(FetchCartItemsEvent());
  }

  double calculateTotal(List<CartItem> cartItems) {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final userid = user?.uid;

    final cartStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('cartitems')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: cartStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final cartItems = snapshot.data!.docs.map((doc) {
            return CartItem(
              itemId: doc['itemId'],
              imagepath: doc['imagepath'],
              name: doc['name'],
              description: doc['description'],
              price: doc['price'].toDouble(),
              quantity: doc['quantity'] as int,
              restaurant: doc['restaurant'],
            );
          }).toList();

          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty.'),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Remove Item'),
                            content: const Text(
                                'Do you want to remove this item from the cart?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(DeleteEvent(item: item));
                                  Navigator.pop(context);
                                },
                                child: const Text('Remove'),
                              ),
                            ],
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            MemoryImage(base64Decode(item.imagepath)),
                      ),
                      title: Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        '₹ ${item.price.toString()}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(RemoveFromCartEvent(item));
                            },
                          ),
                          Text(
                            item.quantity.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(AddToCartEvent(item));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Subtotal: ₹ ${calculateTotal(cartItems).toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    BlocListener<AddressBloc, AddressState>(
                      listener: (context, state) {},
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<AddressBloc>().add(FetchAddresses());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddressListingPage(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                        ),
                        child: const Text(
                          'Checkout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
