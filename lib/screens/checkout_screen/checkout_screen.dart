import 'dart:convert';

import 'package:fastfood/bloc/order/bloc/order_bloc.dart';
import 'package:fastfood/bloc/restauant/bloc/check_out/bloc/check_out_bloc.dart';
import 'package:fastfood/models/usermodel/cart_Items.dart';
import 'package:fastfood/models/usermodel/address_model.dart';
import 'package:fastfood/repository/Address/address_repository.dart';
import 'package:fastfood/repository/Order/order_repo.dart';
import 'package:fastfood/repository/cart/cart_repository.dart';
import 'package:fastfood/repository/search/payment_completed/payment_completed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPageContent extends StatelessWidget {
  String selectedPaymentMethod = '';
  final Address selectedaddress;

  CheckoutPageContent({Key? key, required this.selectedaddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckOutBloc(
          CartRepository(), AddressRepository(), OrderRepository()),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 225, 225),
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            'Checkout',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: BlocListener<CheckOutBloc, CheckOutState>(
          listener: (context, state) {
            if (state is CheckoutErrorState) {
              // Handle error state if needed
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          child: BlocBuilder<CheckOutBloc, CheckOutState>(
            builder: (context, state) {
              context.read<CheckOutBloc>().add(LoadCheckoutDetailsEvent());
              if (state is CheckoutLoadedState) {
                return Container(
                  color: const Color.fromARGB(255, 248, 247, 247),
                  child: Column(
                    children: [
                      _buildCheckoutDetails(state, context),
                      _buildTotalAmount(state.totalAmount),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.payment),
                onPressed: () {
                  _showPaymentOptionsBottomSheet(context);
                },
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    _evaluatePayment(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.orange, // Change the button color to orange
                  ),
                  child: const Text('Make Payment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutDetails(
      CheckoutLoadedState state, BuildContext context) {
    context.read<CheckOutBloc>().add(
          LoadCheckoutDetailsEvent(),
        );

    return BlocBuilder<CheckOutBloc, CheckOutState>(
      builder: (context, state) {
        if (state is CheckoutLoadedState) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildCartItems(state.cartItems),
                const SizedBox(height: 20),
                _buildSelectedAddress(),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildCartItems(List<CartItem> cartItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(12, 8, 8, 8),
          child: Text(
            'Cart iteams',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final item = cartItems[index];
            const Text('');
            return ListTile(
              leading: CircleAvatar(
                  backgroundImage: MemoryImage(base64Decode(item.imagepath))),
              title: Text(
                item.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${item.price} x ${item.quantity}'),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSelectedAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'delivery address:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            ' Name    :${selectedaddress.name}\n Street    : ${selectedaddress.street}\n City        : ${selectedaddress.city}\n Pincode :${selectedaddress.postalCode}\n Phone    :${selectedaddress.Phonenumber}',
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            // Navigator.pop(context);
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Select Payment Method',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: _buildPaymentMethodOptions()),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: const Text('Confirm Payment'),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<String> paymentMethods = ['Cash on Delivery', 'razorpay'];

  // Widget _buildPaymentMethodOptions() {
  //   return BlocBuilder<CheckOutBloc, CheckOutState>(
  //     builder: (context, state) {
  //       context.read<CheckOutBloc>().add(LoadCheckoutDetailsEvent());
  //       if (state is CheckoutLoadedState) {
  //         return Column(
  //           children: paymentMethods.map((method) {
  //             return RadioListTile(
  //               title: Text(method),
  //               value: method,
  //               groupValue: state.paymentMethod,
  //               onChanged: (value) {
  //                 context
  //                     .read<CheckOutBloc>()
  //                     .add(SetPaymentMethodEvent(method));
  //                 selectedPaymentMethod = state.paymentMethod;
  //                 print(selectedPaymentMethod);
  //               },
  //             );
  //           }).toList(),
  //         );
  //       }
  //       return const SizedBox(); // Return an empty widget if state is not CheckoutLoadedState
  //     },
  //   );
  // }
  Widget _buildPaymentMethodOptions() {
    return BlocBuilder<CheckOutBloc, CheckOutState>(
      builder: (context, state) {
        context.read<CheckOutBloc>().add(LoadCheckoutDetailsEvent());
        if (state is CheckoutLoadedState) {
          return Column(
            children: paymentMethods.map((method) {
              return RadioListTile(
                title: Text(method),
                value: method,
                groupValue: selectedPaymentMethod, // Change here
                onChanged: (value) {
                  context
                      .read<CheckOutBloc>()
                      .add(SetPaymentMethodEvent(method));
                  selectedPaymentMethod =
                      method; // Update the selectedPaymentMethod
                  print(selectedPaymentMethod);
                },
              );
            }).toList(),
          );
        }
        return const SizedBox(); // Return an empty widget if state is not CheckoutLoadedState
      },
    );
  }

  // void _evaluatePayment(BuildContext context) {
  //   if (selectedPaymentMethod.isNotEmpty) {
  //     if (selectedPaymentMethod == 'razorpay') {
  //       print('hiiii');
  //       final checkOutBloc = context.read<CheckOutBloc>();
  //       if (checkOutBloc.state is CheckoutLoadedState) {
  //         final checkoutState = checkOutBloc.state as CheckoutLoadedState;
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => PaymentCompletedPage()));
  //         // final addresses = checkoutState.addresses;
  //         final cartItems = checkoutState.cartItems;
  //         final totalAmount = checkoutState.totalAmount;

  //         context
  //             .read<OrderBloc>()
  //             .add(PlaceOrderEvent(selectedaddress, cartItems, totalAmount));
  //         context
  //             .read<CartRepository>()
  //             .deleteCartItems(FirebaseAuth.instance.currentUser!.uid);
  //       }
  //     } else if (selectedPaymentMethod == 'Cash on Delivery') {
  //       final checkOutBloc = context.read<CheckOutBloc>();

  //       final checkoutState = checkOutBloc.state;
  //       if (checkoutState is CheckoutLoadedState) {
  //         final cartItems = checkoutState.cartItems;
  //         final totalAmount = checkoutState.totalAmount;

  //         context.read<CheckOutBloc>().add(RazorpayEvent(
  //             amount: totalAmount,
  //             selectedaddress: selectedaddress,
  //             cartItems: cartItems));

  //         context.read<CheckOutBloc>().stream.listen((state) {
  //           if (state is RazorpayedState && state.status == 'payment success') {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => PaymentCompletedPage()));
  //             context.read<OrderBloc>().add(PlaceOrderEvent(
  //                   selectedaddress,
  //                   cartItems,
  //                   totalAmount,
  //                 ));
  //             context
  //                 .read<CartRepository>()
  //                 .deleteCartItems(FirebaseAuth.instance.currentUser!.uid);
  //           }
  //         });
  //       }
  //     }
  //   } else {}
  // }

  void _evaluatePayment(BuildContext context) {
    if (selectedPaymentMethod.isNotEmpty) {
      if (selectedPaymentMethod == 'razorpay') {
        final checkOutBloc = context.read<CheckOutBloc>();
        final checkoutState = checkOutBloc.state;

        if (checkoutState is CheckoutLoadedState) {
          final cartItems = checkoutState.cartItems;
          final totalAmount = checkoutState.totalAmount;
          context.read<CheckOutBloc>().add(RazorpayEvent(
              amount: totalAmount,
              selectedaddress: selectedaddress,
              cartItems: cartItems));

          context.read<CheckOutBloc>().stream.listen((state) {
            if (state is RazorpayedState && state.status == 'payment success') {
              print('hiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentCompletedPage()));
              context.read<OrderBloc>().add(PlaceOrderEvent(
                    selectedaddress,
                    cartItems,
                    totalAmount,
                  ));
              CartRepository()
                  .deleteCartItems(FirebaseAuth.instance.currentUser!.uid);
            }
          });
        }
      } else if (selectedPaymentMethod == 'Cash on Delivery') {
        final checkOutBloc = context.read<CheckOutBloc>();
        final checkoutState = checkOutBloc.state;

        if (checkoutState is CheckoutLoadedState) {
          final cartItems = checkoutState.cartItems;
          final totalAmount = checkoutState.totalAmount;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PaymentCompletedPage()));

          context
              .read<OrderBloc>()
              .add(PlaceOrderEvent(selectedaddress, cartItems, totalAmount));
          CartRepository()
              .deleteCartItems(FirebaseAuth.instance.currentUser!.uid);
        }
      }
    }
  }

  Widget _buildTotalAmount(double totalAmount) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Amount:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '₹$totalAmount',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
