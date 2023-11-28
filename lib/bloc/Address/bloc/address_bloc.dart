import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fastfood/models/usermodel/address_model.dart';
import 'package:fastfood/repository/Address/address_repository.dart';
import 'package:meta/meta.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressRepository;
  int selectedAddressIndex = -1; // Default value for selected index

  AddressBloc({required this.addressRepository}) : super(AddressInitial()) {
    on<AddAddress>(_addAddress);
    on<FetchAddresses>(_fetchAddresses);
    on<ListAddresses>(_listAddresses);
    on<SelectAddressEvent>(_selectAddress);
    on<DeleteAddress>(deleteAddress);
  }

  void _addAddress(AddAddress event, Emitter<AddressState> emit) async {
    emit(AddressLoading());

    try {
      // Call the repository method to add the address
      await addressRepository.addAddressToUserCollection(event.address);

      emit(AddressAddedSuccessfully(message: 'Address added successfully'));
    } catch (e) {
      emit(AddressOperationFailed(
          errorMessage: 'Failed to add the address: $e'));
    }
  }

  void _fetchAddresses(FetchAddresses event, Emitter<AddressState> emit) async {
    try {
      final List<Address> addresses = await addressRepository.fetchAddresses();
      emit(AddressListedState(addresses: addresses));
    } catch (e) {
      emit(AddressOperationFailed(
          errorMessage: 'Failed to fetch addresses: $e'));
    }
  }

  void _listAddresses(ListAddresses event, Emitter<AddressState> emit) {
    emit(AddressListedState(addresses: event.addresses));
  }

  void _selectAddress(SelectAddressEvent event, Emitter<AddressState> emit) {
    selectedAddressIndex = event.selectedAddressIndex;
    // final selectedaddress = event.selected;
    emit(SelectedAddressChanged(
      selectedAddressIndex,
      // selectedaddress
    ));
  }

  Future<void> deleteAddress(
      DeleteAddress event, Emitter<AddressState> emit) async {
    emit(AddressLoading());

    try {
      // Call the repository method to delete the address
      await addressRepository.deleteAddressFromUserCollection(event.address);

      // emit(AddressOperationSuccess(message: 'Address deleted successfully'));
    } catch (e) {
      emit(AddressOperationFailed(
          errorMessage: 'Failed to delete the address: $e'));
    }
  }
}
