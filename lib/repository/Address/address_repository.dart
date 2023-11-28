// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/models/usermodel/address_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  List<Address> fetchedAddresses = []; // New list to store fetched addresses

  Future<void> addAddressToUserCollection(Address address) async {
    final userid = user?.uid;
    try {
      await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('addresses')
          .add({
        'name': address.name,
        'street': address.street,
        'city': address.city,
        'postalCode': address.postalCode,
        'phoneNumber': address.Phonenumber
        // Include any other necessary fields related to the address
      });
    } catch (e) {
      throw Exception('Failed to add address: $e');
    }
  }

  Future<List<Address>> fetchAddresses() async {
    final userid = user?.uid;
    final querySnapshot = await _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('addresses')
        .get();

    fetchedAddresses = querySnapshot.docs.map((doc) {
      print(fetchedAddresses);
      final data = doc.data();
      return Address(
          name: data['name'],
          street: data['street'],
          city: data['city'],
          postalCode: data['postalCode'],
          Phonenumber: data['phoneNumber']
          // Include any other fields you saved for the address
          );
    }).toList();
    return fetchedAddresses;
  }

  // Method to return the stored fetched addresses
  List<Address> getFetchedAddresses() {
    return fetchedAddresses;
  }

  Future<void> deleteAddressFromUserCollection(Address address) async {
    final userid = user?.uid;

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('addresses')
          .where('street',
              isEqualTo: address
                  .street) // You might want to change the condition based on your unique identifier for an address
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final documentId = querySnapshot.docs.first.id;
        await _firestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('addresses')
            .doc(documentId)
            .delete();
      } else {
        throw Exception('Address not found');
      }
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }
}
