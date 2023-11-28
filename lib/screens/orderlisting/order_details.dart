import 'package:fastfood/models/order_model/order_model.dart';

import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  final Orders order;

  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 203, 203, 203),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID: ${order.orderId}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Order Status: ${order.orderstatu}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Address:\n${order.address.name}\n${order.address.street}\n${order.address.city}\n${order.address.postalCode}',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Items:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: order.items.length,
                    itemBuilder: (context, index) {
                      final item = order.items[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Item ${index + 1}:'),
                          Text('Quantity: ${item.name}'),
                          Text('Description: ${item.description}'),
                          Text('Price: ${item.price}'),
                          Text('Quantity: ${item.quantity}'),
                          const SizedBox(height: 10),
                          const Divider(), // Add a divider between items
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text('Total: ${order.totalAmount}'),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
