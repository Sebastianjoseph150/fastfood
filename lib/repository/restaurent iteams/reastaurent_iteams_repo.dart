import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/models/usermodel/Restaurent/restaurent.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:flutter/foundation.dart';

class RestaurentRepo {
  List<Restaurant> allRestaurants = [];
  List<Restaurant> searchResults = [];
  List<Restaurant> allrestSearch = [];

  List<String> categories = [
    'veg items',
    'non-veg items',
    'bread items',
    'main courses',
    'starters',
    'pizza',
    'burger'
  ];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Set<String> uniqueRestaurantid = {};

  Future<List<Restaurant>> fetchAllRestaurants() async {
    allRestaurants.clear(); // Clear the list before adding new restaurants

    try {
      final List<String> userIds = await fetchAllUserIds();

      for (final String userId in userIds) {
        final QuerySnapshot restaurantsSnapshot = await _firestore
            .collection('users')
            .doc(userId)
            .collection('restaurants')
            .get();

        for (final QueryDocumentSnapshot restaurantDoc
            in restaurantsSnapshot.docs) {
          final Map<String, dynamic>? data =
              restaurantDoc.data() as Map<String, dynamic>?;

          if (data != null) {
            Restaurant restaurant = Restaurant(
              id: restaurantDoc.id,
              name: data['name'] as String? ?? '',
              description: data['description'] as String? ?? '',
              imageUrl: data['imageUrl'] as String? ?? '',
            );
            print(
              data['imageUrl'] as String? ?? '',
            );
            allRestaurants.add(restaurant);

            allrestSearch.add(restaurant);
          }
        }
      }

      return allRestaurants;
    } catch (e) {
      print('Error fetching restaurants: $e');
      rethrow;
    }
  }

  Future<List<FeaturedDish>> fetchProductsForRestaurant(
      String restaurantName) async {
    List<FeaturedDish> productsForRestaurant = [];

    try {
      final List<String> userIds = await fetchAllUserIds();

      for (final String userId in userIds) {
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
              productsForRestaurant.add(featuredDish);
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching products for restaurant $restaurantName: $e');
      }
      rethrow;
    }

    return productsForRestaurant;
  }

  // Function to fetch all user IDs
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

  // Function to clear search results
  // void clearSearchResults() {
  //   print('');
  //   searchResults.clear();
  // }

  List<Restaurant> searchRestaurants(String query) {
    searchResults.clear();
    Set<String> uniqueProductIds = {};

    for (Restaurant restaurant in allrestSearch) {
      if (restaurant.name.toLowerCase().contains(query.toLowerCase()) &&
          uniqueProductIds.add(restaurant.id)) {
        searchResults.add(restaurant);
      }
    }

    if (searchResults.isNotEmpty) {
      print("yes");
    }
    fetchAllRestaurants();

    return searchResults;
  }
}
