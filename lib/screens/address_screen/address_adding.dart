import 'package:fastfood/bloc/Address/bloc/address_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fastfood/models/usermodel/address_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _phonenumbercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: 600,
            decoration: BoxDecoration(
              color: Colors.grey, // Background color
              borderRadius: BorderRadius.circular(8.0), // Border radius
              border: Border.all(color: Colors.black, width: 2.0), // Border
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2, 2),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _streetController,
                        decoration: const InputDecoration(labelText: 'Street'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the street';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _cityController,
                        decoration: const InputDecoration(labelText: 'City'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the city';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _postalCodeController,
                        decoration:
                            const InputDecoration(labelText: 'Postal Code'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the postal code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _phonenumbercontroller,
                        decoration:
                            const InputDecoration(labelText: 'Phone number'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the Phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      BlocListener<AddressBloc, AddressState>(
                        listener: (context, state) {},
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final address = Address(
                                name: _nameController.text,
                                street: _streetController.text,
                                city: _cityController.text,
                                postalCode: _postalCodeController.text,
                                Phonenumber: _phonenumbercontroller.text,
                              );
                              context
                                  .read<AddressBloc>()
                                  .add(AddAddress(address: address));
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Add Address'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
