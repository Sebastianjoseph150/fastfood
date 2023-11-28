part of 'check_out_bloc.dart';

sealed class CheckOutState extends Equatable {
  const CheckOutState();

  @override
  List<Object> get props => [];
}

final class CheckOutInitial extends CheckOutState {}

class CheckoutLoadedState extends CheckOutState {
  final List<CartItem> cartItems;

  final List<Address> addresses;
  final double totalAmount;
  final String appliedCoupon;
  final double discountedAmount;
  final String paymentMethod;

  const CheckoutLoadedState({
    required this.paymentMethod,
    required this.cartItems,
    required this.addresses,
    required this.totalAmount,
    this.appliedCoupon = '',
    this.discountedAmount = 0.0,
  });

  CheckoutLoadedState copyWith(
      {List<CartItem>? cartItems,
      List<Address>? addresses,
      double? totalAmount,
      String? appliedCoupon,
      double? discountedAmount,
      String? paymentMethod}) {
    return CheckoutLoadedState(
        cartItems: cartItems ?? this.cartItems,
        addresses: addresses ?? this.addresses,
        totalAmount: totalAmount ?? this.totalAmount,
        appliedCoupon: appliedCoupon ?? this.appliedCoupon,
        discountedAmount: discountedAmount ?? this.discountedAmount,
        paymentMethod: paymentMethod ?? this.paymentMethod);
  }
}

class CheckoutErrorState extends CheckOutState {
  final String errorMessage;

  const CheckoutErrorState({required this.errorMessage});
}

class SelectedPaymentChangedState extends CheckOutState {
  final String selectedPaymentMethod;

  const SelectedPaymentChangedState({required this.selectedPaymentMethod});

  @override
  List<Object> get props => [selectedPaymentMethod];
}

class RazorpayingState extends CheckOutState {}

class RazorpayedState extends CheckOutState {
  final String status;

  const RazorpayedState({required this.status});
}
