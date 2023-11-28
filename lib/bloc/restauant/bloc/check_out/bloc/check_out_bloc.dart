import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastfood/models/usermodel/address_model.dart';
import 'package:fastfood/models/usermodel/cart_Items.dart';
import 'package:fastfood/repository/Address/address_repository.dart';
import 'package:fastfood/repository/Order/order_repo.dart';
import 'package:fastfood/repository/cart/cart_repository.dart';

part 'check_out_event.dart';
part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  final CartRepository cartRepository;
  String selectedPaymentMethod =
      ''; // Variable to hold the selected payment method

  final AddressRepository addressRepository;
  final OrderRepository orderRepository;

  CheckOutBloc(
      this.cartRepository, this.addressRepository, this.orderRepository)
      : super(CheckOutInitial()) {
    on<LoadCheckoutDetailsEvent>(_loadCheckoutDetailsEvent);
    // on<ApplyCouponEvent>(_applyCouponEvent);
    on<SetPaymentMethodEvent>(_setPaymentMethodEvent);
    on<RazorpayEvent>(razorpayEvent);
  }

  Future<void> _loadCheckoutDetailsEvent(
      LoadCheckoutDetailsEvent event, Emitter<CheckOutState> emit) async {
    try {
      final List<CartItem> fetchCartItems =
          await cartRepository.fetchCartItemsFromFirebase();
      final List<Address> selectedAddresses =
          addressRepository.fetchedAddresses;
      double totalAmount = 0.0;

      for (var item in fetchCartItems) {
        totalAmount += item.price * item.quantity;
      }
      emit(CheckoutLoadedState(
          addresses: selectedAddresses,
          totalAmount: totalAmount,
          appliedCoupon: '',
          cartItems: fetchCartItems,
          discountedAmount: totalAmount,
          paymentMethod: selectedPaymentMethod));
    } catch (error) {
      emit(const CheckoutErrorState(errorMessage: 'Failed to load checkout details'));
    }
  }

  // Future<void> _applyCouponEvent(
  //     ApplyCouponEvent event, Emitter<CheckOutState> emit) async {
  //   try {
  //     if (state is CheckoutLoadedState) {
  //       final CheckoutLoadedState currentState = state as CheckoutLoadedState;

  //       final String appliedCoupon = event.couponCode;

  //       double discountedAmount = currentState.totalAmount;
  //       if (appliedCoupon == 'COUPON10') {
  //         discountedAmount *= 0.9;
  //       }
  //     }
  //   } catch (error) {
  //     emit(CheckoutErrorState(errorMessage: 'Failed to apply the coupon'));
  //   }
  // }

  Future<void> _setPaymentMethodEvent(
      SetPaymentMethodEvent event, Emitter<CheckOutState> emit) async {
    // Set the selected payment method when receiving the event
    selectedPaymentMethod = event.paymentMethod;
    print(selectedPaymentMethod);
    // Emit state with updated payment method (if needed)
    emit(CheckoutLoadedState(
      addresses: (state as CheckoutLoadedState).addresses,
      totalAmount: (state as CheckoutLoadedState).totalAmount,
      appliedCoupon: (state as CheckoutLoadedState).appliedCoupon,
      cartItems: (state as CheckoutLoadedState).cartItems,
      discountedAmount: (state as CheckoutLoadedState).discountedAmount,
      paymentMethod: selectedPaymentMethod,
    ));
    emit(SelectedPaymentChangedState(
        selectedPaymentMethod: event.paymentMethod));
  }

  FutureOr<void> razorpayEvent(
      RazorpayEvent event, Emitter<CheckOutState> emit) async {
    emit(RazorpayingState());
    try {
      final razorpaystatus = orderRepository.startPayment(event.amount);
      
      emit(RazorpayedState(status: razorpaystatus));
    } catch (errro) {
      (e);
    }
  }
}
