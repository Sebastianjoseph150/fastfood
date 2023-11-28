import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:flutter/foundation.dart';

class FeaturedDishesRepository {
  final List<FeaturedDish> allUsersFeaturedDishes = [];
  List<FeaturedDish> featuredListSearchResult = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> categories = [
    'veg items',
    'non-veg items',
    'bread items',
    'main courses',
    'starters',
    'pizza',
    'burger'
  ];

  Future<List<FeaturedDish>> fetchUserProducts() async {
    allUsersFeaturedDishes.clear();

    final List<String> userIds = await fetchAllUserIds();

    for (final String userId in userIds) {
      // print('i am here');

      try {
        for (String category in categories) {
          final QuerySnapshot productsSnapshot = await _firestore
              .collection('users')
              .doc(userId)
              .collection(category)
              .get();

          for (final QueryDocumentSnapshot productDocument
              in productsSnapshot.docs) {
            final Map<String, dynamic>? data =
                productDocument.data() as Map<String, dynamic>?;

            if (data != null) {
              FeaturedDish featuredDish = FeaturedDish(
                id: productDocument.id,
                name: data['name'] as String? ?? '',
                price: data['price'] as String? ?? '',
                description: data['description'] as String? ?? '',
                category: data['category'] as String? ?? '',
                imageUrl: data['imageUrl'] as String? ?? '',
                restaurant: data['restaurent'] as String? ?? '',
              );
              allUsersFeaturedDishes.add(featuredDish);
            }
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching user products for userId $userId: $e');
        }
      }
    }
    return allUsersFeaturedDishes;
  }

  Future<List<String>> fetchAllUserIds() async {
    try {
      final QuerySnapshot usersSnapshot =
          await _firestore.collection('users').get();

      final List<String> allUserIds = [];

      for (final QueryDocumentSnapshot userDocument in usersSnapshot.docs) {
        allUserIds.add(userDocument.id);
      }

      return allUserIds;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching all user IDs: $e');
      }
      rethrow;
    }
  }

  List<FeaturedDish> searchFeaturedDishes(String query) {
    List<FeaturedDish> allRestaurantssearch = allUsersFeaturedDishes;

    Set<String> uniqueProductIds = {};

    featuredListSearchResult.clear();

    for (FeaturedDish dish in allRestaurantssearch) {
      if (dish.name.toLowerCase().contains(query.toLowerCase()) &&
          uniqueProductIds.add(dish.id)) {
        featuredListSearchResult.add(dish);
      }
    }
    fetchUserProducts();
    return featuredListSearchResult;
  }
}
