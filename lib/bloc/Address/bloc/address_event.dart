part of 'address_bloc.dart';

@immutable
abstract class AddressEvent {}

class AddAddress extends AddressEvent {
  final Address address;

  AddAddress({required this.address});
}

class FetchAddresses extends AddressEvent {}

class ListAddresses extends AddressEvent {
  final List<Address> addresses;

  ListAddresses({required this.addresses});
}

class SelectAddressEvent extends AddressEvent {
  final int selectedAddressIndex;
  // final Address selected;

  SelectAddressEvent(
      // this.selected
      // ,
      {required this.selectedAddressIndex});
}

class DeleteAddress extends AddressEvent {
  final Address address;

  DeleteAddress({required this.address});
}
