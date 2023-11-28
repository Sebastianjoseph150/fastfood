part of 'cart_bloc.dart';

abstract class CartEvent {}

class FetchCartItemsEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final CartItem cartItem;

  AddToCartEvent(this.cartItem);
}

class RemoveFromCartEvent extends CartEvent {
  final CartItem item;

  RemoveFromCartEvent(this.item);
}

class DeleteEvent extends CartEvent {
  final CartItem item;

  DeleteEvent({required this.item});
}
