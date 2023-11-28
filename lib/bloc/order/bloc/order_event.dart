part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrderEvent extends OrderEvent {
  final Address addresses;
  final List<CartItem> cartItems;
  final double totalAmount;

  const PlaceOrderEvent(this.addresses, this.cartItems, this.totalAmount);
}

class FetchOrderHistoryEvent extends OrderEvent {
  final String userId;

  const FetchOrderHistoryEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
