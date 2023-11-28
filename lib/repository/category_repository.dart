import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<FeaturedDish> categorys = [];
  final List<FeaturedDish> categorydata = [];

  Future<List<FeaturedDish>> fetchUserProductsByCategory(
      String category) async {
    final List<String> userIds = await fetchAllUserIds();
    final List<FeaturedDish> categoryData = [];

    for (final String userId in userIds) {
      try {
        print(category);
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
              restaurant: data['restaurant'] as String? ?? '',
            );
            categoryData.add(featuredDish);
          }
        }
      } catch (e) {
        // Log the error
        print('Error fetching user products for userId $userId: $e');
      }
    }
    return categoryData;
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
      print('Error fetching all user IDs: $e');
      rethrow;
    }
  }
}
