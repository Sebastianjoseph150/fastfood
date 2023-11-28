import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';

class FavoriteRepository {
  final List<FeaturedDish> Faviteams = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>>? _favoriteCollection;

  FavoriteRepository() {
    _initializeFavoriteCollection();
  }

  Future<void> _initializeFavoriteCollection() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userid = user.uid;
      _favoriteCollection =
          _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('favorites');
    } else {}
  }

  Future<bool> isFavorite(String item) async {
    if (_favoriteCollection != null) {
      try {
        final doc = await _favoriteCollection!.doc(item).get();
        return doc.exists;
      } catch (e) {
        print('Error checking if favorite: $e');
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> addToFavorites(String item, FeaturedDish productDetails) async {
    if (_favoriteCollection != null) {
      try {
        final productData = productDetails.toMap();

        await _favoriteCollection!.doc(item).set(productData);
      } catch (e) {
        print('Error adding to favorites: $e');
      }
    }
  }

  Future<void> removeFromFavorites(String item) async {
    if (_favoriteCollection != null) {
      try {
        await _favoriteCollection!.doc(item).delete();
      } catch (e) {
        print('Error removing from favorites: $e');
      }
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllFavoriteItems() async {
    if (_favoriteCollection != null) {
      try {
        final querySnapshot = await _favoriteCollection!.get();
        final favoriteItems = querySnapshot.docs.map((doc) {
          final data = doc.data();

          return data;
        }).toList();

        return favoriteItems;
      } catch (e) {
        print('Error fetching favorite items: $e');
      }
    }
    return [];
  }
}
