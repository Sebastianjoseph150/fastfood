import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  final List<String> bannerImages = [
    'assets/images/banner/banner2.jpeg',
    'assets/images/banner/banner2.jpeg',
    'assets/images/banner/banner2.jpeg',
  ];

  BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: bannerImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              width: 380,
              margin: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  bannerImages[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
