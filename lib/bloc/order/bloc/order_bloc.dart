import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fastfood/models/order_model/order_model.dart';
import 'package:fastfood/models/usermodel/address_model.dart';
import 'package:fastfood/models/usermodel/cart_Items.dart';
import 'package:fastfood/repository/Order/order_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<PlaceOrderEvent>(_placeOrderEvent);
    on<FetchOrderHistoryEvent>(fetchOrderHistoryEvent);
  }

  Future<void> _placeOrderEvent(
      PlaceOrderEvent event, Emitter<OrderState> emit) async {
    try {
      await orderRepository.placeOrder(
          addresses: event.addresses,
          cartItems: event.cartItems,
          totalAmount: event.totalAmount);

      emit(OrderPlacedSuccess());
    } catch (error) {
      emit(OrderPlacementFailure(error.toString()));
    }
  }

  // Future<void> _fetchOrdersEvent(
  //   FetchOrdersEvent event,
  //   Emitter<OrderState> emit,
  // ) async {

  // }

  FutureOr<void> fetchOrderHistoryEvent(
      FetchOrderHistoryEvent event, Emitter<OrderState> emit) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        emit(OrderHistoryLoading());
        final orderHistory = await orderRepository.fetchOrderHistory(userId);

        emit(OrderHistoryLoaded(orderHistory));
      } else {
        emit(OrderHistoryLoadFailure('User not logged in.'));
      }
    } catch (error) {
      emit(OrderHistoryLoadFailure(error.toString()));
    }
  }
}
