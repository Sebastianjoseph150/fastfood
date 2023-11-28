import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/models/usermodel/cart_Items.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;

  Future<List<CartItem>> fetchCartItemsFromFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    final userid = user?.uid;

    final userCartRef =
        _firestore.collection('users').doc(userid).collection('cartitems');

    final querySnapshot = await userCartRef.get();
    final cartItems =
        querySnapshot.docs.map((doc) => CartItem.fromMap(doc.data())).toList();
    return cartItems;
  }

  Future<void> addToCart(CartItem item) async {
    // final userid = user?.uid;
    final userCartRef = _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cartitems');

    final querySnapshot =
        await userCartRef.where('itemId', isEqualTo: item.itemId).get();
    final itemExists = querySnapshot.docs.isNotEmpty;

    if (itemExists) {
      print('Item already exists in the cart. Incrementing the quantity...');

      final existingDoc = querySnapshot.docs.first;
      final existingQuantity = existingDoc['quantity'] as int;
      await existingDoc.reference.update({'quantity': existingQuantity + 1});
    } else {
      item.quantity = 1;
      await userCartRef.add(item.toMap());
    }
  }

  Future<void> removeFromCart(CartItem item) async {
    final userid = user?.uid;
    final userCartRef = _firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cartitems');

    final querySnapshot =
        await userCartRef.where('itemId', isEqualTo: item.itemId).get();
    final itemExists = querySnapshot.docs.isNotEmpty;

    if (itemExists) {
      final existingDoc = querySnapshot.docs.first;
      final existingQuantity = existingDoc['quantity'] as int;

      if (existingQuantity > 1) {
        await existingDoc.reference.update({'quantity': existingQuantity - 1});
      } else {
        await existingDoc.reference.delete();
      }
    }
  }

  Future<void> delete(CartItem item) async {
    final userid = user?.uid;
    final userCartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cartitems');

    final querySnapshot =
        await userCartRef.where('itemId', isEqualTo: item.itemId).get();
    final itemExists = querySnapshot.docs.isNotEmpty;

    if (itemExists) {
      final existingDoc = querySnapshot.docs.first;
      await existingDoc.reference.delete();
    }
  }

  Future<void> deleteCartItems(String userId) async {
    print('hiiiiiiiiiiiiii');
    try {
      print(FirebaseAuth.instance.currentUser!.uid);
      final userCartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cartitems');

      // Get all documents in the cartitems collection
      final QuerySnapshot cartItemsSnapshot = await userCartRef.get();

      // Create a batch operation
      WriteBatch batch = FirebaseFirestore.instance.batch();

      // Delete each document in the collection
      for (var doc in cartItemsSnapshot.docs) {
        batch.delete(doc.reference);
      }

      // Commit the batch operation
      await batch.commit();

      print('Cart items deleted successfully');
    } catch (e) {
      print('Error deleting cart items: $e');
      // Handle any errors that occurred during deletion
    }
  }
}
