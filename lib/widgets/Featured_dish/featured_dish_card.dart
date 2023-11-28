import 'dart:convert';
import 'dart:typed_data';

import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:flutter/material.dart';

class FeaturedDishCard extends StatelessWidget {
  final FeaturedDish featuredDish;

  const FeaturedDishCard({super.key, required this.featuredDish});

  @override
  Widget build(BuildContext context) {
    final String img = featuredDish.imageUrl;
    final Uint8List imageready = base64Decode(img);
    return SizedBox(
      width: 300, // Set the desired width
      child: SizedBox(
        width: 300,
        height: 300,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio:
                    1.8, // Set the desired aspect ratio (1.0 for a square aspect ratio)
                child: Image.memory(
                  imageready,
                  fit: BoxFit.fill, // Ensure the image fills the container
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
                child: Text(
                  featuredDish.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 2, 8),
                child: Text(
                  '₹${featuredDish.price.toString()}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
