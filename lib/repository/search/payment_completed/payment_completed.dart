import 'package:fastfood/screens/orderlisting/oreder_listing.dart';
import 'package:flutter/material.dart';

class PaymentCompletedPage extends StatelessWidget {
  const PaymentCompletedPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const OrderListingPage()));
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Completed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Placed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderListingPage()));
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
