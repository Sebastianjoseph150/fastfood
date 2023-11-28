import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/models/order_model/order_model.dart';
import 'package:fastfood/models/usermodel/address_model.dart';
import 'package:fastfood/models/usermodel/cart_Items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderRepository {
  final Razorpay _razorpay = Razorpay();
  String completer = '';

  String startPayment(double amount) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    var options = {
      'key': 'rzp_test_byX4xjQdkJOyzX',
      'amount': amount * 100,
      'name': 'Fast food',
      'description': 'food order',
      'prefill': {
        'contact': '8157966506',
        'email': 'sebastianjoseph150@gmail.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    _razorpay.open(options);

    return completer;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('payment success ${response.paymentId}');
    completer = 'payment success';
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('payment faild');
    completer = 'payment success';
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  Future<void> placeOrder({
    required Address addresses,
    required List<CartItem> cartItems,
    required double totalAmount,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user!.uid;

    try {
      Map<String, List<CartItem>> restaurantItemsMap = {};

      for (var cartItem in cartItems) {
        if (!restaurantItemsMap.containsKey(cartItem.restaurant)) {
          restaurantItemsMap[cartItem.restaurant] = [];
        }
        restaurantItemsMap[cartItem.restaurant]?.add(cartItem);
      }

      for (var restaurantItems in restaurantItemsMap.values) {
        if (restaurantItems.isNotEmpty) {
          Orders order = Orders(
              orderId: DateTime.now().millisecondsSinceEpoch.toString(),
              userId: userId,
              address: addresses,
              items: restaurantItems,
              totalAmount: totalAmount,
              orderDate: DateTime.now(),
              quantity: restaurantItems.length,
              restaurant: restaurantItems[0].restaurant,
              orderstatu: 'pending order',
              orderstausid: userId);

          await _saveOrderToFirestore(userId, order);
        }
      }
    } catch (e) {
      throw Exception('Failed to place the order: $e');
    }
  }

  Future<void> _saveOrderToFirestore(String userId, Orders order) async {
    try {
      final orderRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders');

      final DocumentReference docRef = await orderRef.add(order.toMap());

      String statusId = docRef.id;
      await docRef.update({'orderstausid': statusId});

      print('Order placed successfully for user $userId');
    } catch (e) {
      throw Exception('Failed to place the order: $e');
    }
  }

  Future<List<Orders>> fetchOrderHistory(String userId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('orders')
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No order history found for user $userId');
      } else {
        final orderHistory = querySnapshot.docs.map((doc) {
          final data = doc.data();
          return Orders.fromMap(data);
        }).toList();
        print('Order history found: $orderHistory');
        return orderHistory.cast<Orders>();
      }
    } catch (e) {
      throw Exception('Failed to fetch order history: $e');
    }
    return [];
  }
}
