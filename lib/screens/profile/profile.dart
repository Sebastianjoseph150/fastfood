import 'package:fastfood/bloc/Address/bloc/address_bloc.dart';
import 'package:fastfood/screens/auth/login/login_screen.dart';
import 'package:fastfood/screens/orderlisting/oreder_listing.dart';
import 'package:fastfood/screens/profile/profileaddress/profile_address.dart';
import 'package:fastfood/screens/terms&conditions/terms&conditons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdditionalInformation extends StatefulWidget {
  const AdditionalInformation({Key? key}) : super(key: key);

  @override
  _AdditionalInformationState createState() => _AdditionalInformationState();
}

class _AdditionalInformationState extends State<AdditionalInformation> {
  final user = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              const CircleAvatar(
                radius: 60,
                // backgroundImage: AssetImage(
                //     'assets/user/images.jpeg'),
                child: Icon(
                  Icons.person,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              const Text(
                '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                '',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading:
                        const Icon(Icons.location_city, color: Colors.black),
                    title: const Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: Colors.black),
                    onTap: () {
                      context.read<AddressBloc>().add(FetchAddresses());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProileAddress()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shield, color: Colors.black),
                    title: const Text(
                      'Privacy policy',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: Colors.black),
                    onTap: () {
                      // Handle onTap action
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book, color: Colors.black),
                    title: const Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: Colors.black54),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TermsAndConditionsPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add_box, color: Colors.black),
                    title: const Text(
                      'My orders',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: Colors.black),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderListingPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 20, color: Colors.black),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Log out'),
                            content:
                                const Text('Are you sure you want to log out?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Log out'),
                                onPressed: () async {
                                  user.signOut();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (route) => false);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
