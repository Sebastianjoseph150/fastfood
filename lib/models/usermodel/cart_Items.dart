// class CartItem {
//   final String itemId; // Add a unique identifier for each item
//   final String name;
//   final String description;
//   final double price;
//   int quantity; // Add the quantity field
//   final String imagepath;
//   final String restaurant;

//   CartItem({
//     required this.itemId, // Pass the item ID as a required parameter
//     required this.imagepath,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.quantity, // Include quantity in the constructor
//     required this.restaurant,
//   });

//   factory CartItem.fromMap(Map<String, dynamic> map) {
//     return CartItem(
//       itemId: map['itemId']
//           as String, // Make sure you include this field in your Firestore document
//       name: map['name'] as String,
//       description: map['description'] as String,
//       price: map['price'] as double,
//       quantity: map['quantity'] as int, // Parse quantity from the map
//       imagepath: map['imagepath'] as String,
//       restaurant: map['restaurant'] as String,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'itemId': itemId, // Include the item ID when saving to Firestore
//       'name': name,
//       'description': description,
//       'price': price,
//       'quantity': quantity,
//       'imagepath': imagepath,
//       'restaurant': restaurant,
//     };
//   }
// }
class CartItem {
  final String itemId;
  final String name;
  final String description;
  final double price;
  int quantity;
  final String imagepath;
  final String restaurant;

  CartItem({
    required this.itemId,
    required this.imagepath,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.restaurant,
  });

  CartItem copyWith({int? quantity, String? restaurant}) {
    return CartItem(
      itemId: itemId,
      name: name,
      description: description,
      price: price,
      quantity: quantity ?? this.quantity,
      imagepath: imagepath,
      restaurant: restaurant ?? this.restaurant,
    );
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      itemId: map['itemId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      imagepath: map['imagepath'] as String,
      restaurant: map['restaurant'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'imagepath': imagepath,
      'restaurant': restaurant,
    };
  }
}
