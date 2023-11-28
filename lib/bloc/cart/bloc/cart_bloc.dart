// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:fastfood/models/usermodel/cart_Items.dart';
// import 'package:fastfood/models/usermodel/featured_dish.dart';
// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
// import '../../../repository/cart/cart_repository.dart';

// part 'cart_event.dart';
// part 'cart_state.dart';

// class CartBloc extends Bloc<CartEvent, CartState> {
//   final CartRepository cartRepository;

//   CartBloc({required this.cartRepository}) : super(CartInitial()) {
//     on<AddToCartEvent>(addToCartEvent);
//     on<RemoveFromCartEvent>(removeFromCartEvent);
//     on<FetchCartItemsEvent>(fetchCartItemsEvent);
//   }

//   FutureOr<void> addToCartEvent(AddToCartEvent event, Emitter<CartState> emit) {
//     try {
//       cartRepository.addToCart(event.cartItem);
//       debugPrint('added to cart');
//       emit(AddedToCart());
//     } catch (e) {
//       throw e.toString();
//     }
//   }

//   FutureOr<void> fetchCartItemsEvent(
//       FetchCartItemsEvent event, Emitter<CartState> emit) async {
//     try {
//       final cartItems = await cartRepository.fetchCartItemsFromFirebase();
//       emit(CartUpdated(cartItems));
//     } catch (e) {
//       emit(CartError('Failed to fetch cart items'));
//     }
//   }

//   FutureOr<void> removeFromCartEvent(
//       RemoveFromCartEvent event, Emitter<CartState> emit) async {
//     try {
//       cartRepository.removeFromCart(event.item);
//       print('hellpppppppppppppppp');
//       final updatedCartItems =
//           await cartRepository.fetchCartItemsFromFirebase();
//       emit(removed(updatedCartItems));
//     } catch (e) {
//       emit(CartError('Failed to remove item from the cart'));
//     }
//   }
// }
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fastfood/models/usermodel/cart_Items.dart';
import 'package:flutter/material.dart';
import '../../../repository/cart/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({required this.cartRepository}) : super(CartInitial()) {
    on<AddToCartEvent>(addToCartEvent);
    on<FetchCartItemsEvent>(fetchCartItemsEvent);
    on<RemoveFromCartEvent>(removeItemFromCartEvent);
    on<DeleteEvent>(deleteEvent);
  }

  Future<void> addToCartEvent(
      AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      cartRepository.addToCart(event.cartItem);
      debugPrint('added to cart');
      emit(AddedToCart());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> fetchCartItemsEvent(
      FetchCartItemsEvent event, Emitter<CartState> emit) async {
    try {
      final cartItems = await cartRepository.fetchCartItemsFromFirebase();
      emit(CartUpdated(cartItems));
    } catch (e) {
      emit(CartError('Failed to fetch cart items'));
    }
  }

  Future<void> removeItemFromCartEvent(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    try {
      cartRepository.removeFromCart(event.item);
      final updatedCartItems =
          await cartRepository.fetchCartItemsFromFirebase();
      emit(CartUpdated(updatedCartItems));
    } catch (e) {
      emit(CartError('Failed to remove item from the cart'));
    }
  }

  FutureOr<void> deleteEvent(event, Emitter<CartState> emit) async {
    try {
      cartRepository.delete(event.item);
      final updatedCartItems =
          await cartRepository.fetchCartItemsFromFirebase();
      emit(CartUpdated(updatedCartItems));
    } catch (e) {
      emit(CartError('Failed to remove item from the cart'));
    }
  }
}
