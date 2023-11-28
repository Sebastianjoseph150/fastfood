part of 'address_bloc.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressAddedSuccessfully extends AddressState {
  final String message;

  AddressAddedSuccessfully({required this.message});
}

class AddressOperationFailed extends AddressState {
  final String errorMessage;

  AddressOperationFailed({required this.errorMessage});
}

class AddressListedState extends AddressState {
  final List<Address> addresses;
  final int? selectedAddressIndex;

  AddressListedState({
    required this.addresses,
    this.selectedAddressIndex,
  });

  // // Get the selected address based on the index
  // Address? getSelectedAddress() {
  //   if (selectedAddressIndex != null &&
  //       selectedAddressIndex! >= 0 &&
  //       selectedAddressIndex! < addresses.length) {
  //     return addresses[selectedAddressIndex!];
  //   }
  //   return null;
  // }
}

class SelectedAddressChanged extends AddressState {
  final int selectedAddressIndex;
  // final Address selected;

  SelectedAddressChanged(
    this.selectedAddressIndex,
    // this.selected
  );
}
