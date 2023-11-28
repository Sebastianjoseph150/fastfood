part of 'check_out_bloc.dart';

sealed class CheckOutEvent extends Equatable {
  const CheckOutEvent();

  @override
  List<Object?> get props => [];
}

class LoadCheckoutDetailsEvent extends CheckOutEvent {}

class ApplyCouponEvent extends CheckOutEvent {
  final String couponCode;

  const ApplyCouponEvent(this.couponCode);

  @override
  List<Object?> get props => [couponCode];
}

class SetPaymentMethodEvent extends CheckOutEvent {
  final String paymentMethod;

  const SetPaymentMethodEvent(this.paymentMethod);

  @override
  List<Object?> get props => [paymentMethod];
}

class RazorpayEvent extends CheckOutEvent {
  final double amount;
  final Address selectedaddress;
  final List<CartItem> cartItems;

  const RazorpayEvent(
      {required this.selectedaddress,
      required this.cartItems,
      required this.amount});
}
