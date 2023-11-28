part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderPlacedSuccess extends OrderState {}

class OrderPlacementFailure extends OrderState {
  final String errorMessage;

  OrderPlacementFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class OrderHistoryLoading extends OrderState {}

class OrderHistoryLoaded extends OrderState {
  final List<Orders> orderHistory;

  OrderHistoryLoaded(this.orderHistory);

  @override
  List<Object> get props => [orderHistory];
}

class OrderHistoryLoadFailure extends OrderState {
  final String errorMessage;

  OrderHistoryLoadFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
