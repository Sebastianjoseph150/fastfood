class FeaturedDish {
  final String id;
  final String name;
  final String price;
  final String description;
  final String category;
  final String imageUrl;
  final String restaurant;
  FeaturedDish({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.restaurant,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'restaurent': restaurant,
    };
  }

  factory FeaturedDish.fromMap(Map<String, dynamic> data) {
    return FeaturedDish(
      id: data['id'],
      name: data['name'],
      price: data['price'],
      description: data['description'],
      category: data['category'],
      imageUrl: data['imageUrl'],
      restaurant: data['restaurent'],
    );
  }
}
