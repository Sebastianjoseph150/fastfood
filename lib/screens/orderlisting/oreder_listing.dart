import 'package:fastfood/repository/Order/order_repo.dart';
import 'package:fastfood/screens/orderlisting/order_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood/bloc/order/bloc/order_bloc.dart';
import 'package:fastfood/models/order_model/order_model.dart';

class OrderListingPage extends StatelessWidget {
  const OrderListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(orderRepository: OrderRepository()),
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          final orderListingBloc = BlocProvider.of<OrderBloc>(context);
          if (state is OrderInitial) {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              orderListingBloc.add(FetchOrderHistoryEvent(user.uid));
            }
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orange,
              title: const Text(
                'Order History',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(state) {
    if (state is OrderInitial || state is OrderHistoryLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is OrderHistoryLoaded) {
      if (state.orderHistory.isEmpty) {
        return const Center(child: Text('No orders available.'));
      } else {
        return _buildOrderList(state.orderHistory);
      }
    } else if (state is OrderHistoryLoadFailure) {
      return Center(child: Text('Error: ${state.errorMessage}'));
    } else {
      return Container(); // You can return an empty container or handle other states
    }
  }

  Widget _buildOrderList(List<Orders> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return GestureDetector(
          child: ListTile(
            title: Text('Order ID: ${order.orderId}'),
            subtitle: Text(
                'Restaurant: ${order.restaurant}\nTotal: \$${order.totalAmount.toStringAsFixed(2)}'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OrderDetailPage(order: orders[index])));
            },
          ),
        );
      },
    );
  }
}
