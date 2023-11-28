import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood/bloc/Address/bloc/address_bloc.dart';
import 'package:fastfood/screens/address_screen/address_adding.dart';
import 'package:fastfood/bloc/restauant/bloc/check_out/bloc/check_out_bloc.dart';
import 'package:fastfood/screens/checkout_screen/checkout_screen.dart';
import 'package:fastfood/models/usermodel/address_model.dart'; // Assuming this is your address model

class AddressListingPage extends StatelessWidget {
  const AddressListingPage({super.key, });

  @override
  Widget build(BuildContext context) {
    final AddressBloc addressBloc = BlocProvider.of<AddressBloc>(context);
    final CheckOutBloc checkOutBloc = BlocProvider.of<CheckOutBloc>(context);

    addressBloc.add(FetchAddresses());

    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        context.read<AddressBloc>().add(FetchAddresses());
        if (state is AddressListedState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Address Listing',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.orange,
            ),
            // backgroundColor: const Color.fromARGB(255, 249, 242, 253),
            body: _addressWidget(state, addressBloc, checkOutBloc, context),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Address Listing'),
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _addressWidget(
    AddressListedState state,
    AddressBloc addressBloc,
    CheckOutBloc checkOutBloc,
    BuildContext context,
  ) {
    return Column(
      children: [
        Expanded(
          child: state.addresses.isNotEmpty
              ? ListView.builder(
                  itemCount: state.addresses.length,
                  itemBuilder: (context, index) {
                    final currentAddress = state.addresses[index];

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: ListTile(
                        leading: Radio(
                          value: index,
                          groupValue: addressBloc.selectedAddressIndex,
                          onChanged: (value) {
                            addressBloc.add(SelectAddressEvent(
                              selectedAddressIndex: index,
                            ));
                          },
                          activeColor: Colors.orange,
                        ),
                        title: Text(
                          currentAddress.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          '${currentAddress.street}, ${currentAddress.city}, ${currentAddress.postalCode}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        onTap: () {
                          addressBloc.add(SelectAddressEvent(
                            selectedAddressIndex: index,
                          ));
                        },
                        onLongPress: () {
                          _showDeleteConfirmationDialog(
                            context,
                            addressBloc,
                            currentAddress,
                          );
                        },
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('No addresses available.'),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAddressPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                  minimumSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 50)),
                ),
                child: const Text(
                  'Add New Address',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              BlocListener<CheckOutBloc, CheckOutState>(
                listener: (context, state) {
                  // Handle CheckOutBloc state changes if needed
                },
                child: ElevatedButton(
                  onPressed: () {
                    final selectedAddressIndex =
                        addressBloc.selectedAddressIndex;
                    checkOutBloc.add(LoadCheckoutDetailsEvent());
                    if (selectedAddressIndex >= 0 &&
                        selectedAddressIndex < state.addresses.length) {
                      final selectedAddress =
                          state.addresses[selectedAddressIndex];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPageContent(
                            selectedaddress: selectedAddress,
                          ),
                        ),
                      );
                    }
                                    },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                    minimumSize: MaterialStateProperty.all<Size>(
                        const Size(double.infinity, 50)),
                  ),
                  child: const Text(
                    'Check Out',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    AddressBloc addressBloc,
    Address addressToDelete,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Address'),
          content: const Text('Are you sure you want to delete this address?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                addressBloc.add(DeleteAddress(address: addressToDelete));
                Navigator.of(context).pop();
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }
}
