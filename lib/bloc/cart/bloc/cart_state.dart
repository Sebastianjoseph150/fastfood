part of 'cart_bloc.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class AddedToCart extends CartState {}

class CartUpdated extends CartState {
  final List<CartItem> cartItems;

  CartUpdated(this.cartItems);
}

class removed extends CartState {
  final List<CartItem> cartItems;

  removed(this.cartItems);
}

class CartError extends CartState {
  final String error;

  CartError(this.error);
}
