import 'package:fastfood/bloc/category/category_bloc.dart';
import 'package:fastfood/widgets/category/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListing extends StatelessWidget {
  final List<Map<String, String>> avatarData = [
    {
      'url': 'assets/images/banner/burger2.jpg',
      'text': 'burger',
    },
    {
      'url': 'assets/images/banner/pizza2.jpeg',
      'text': 'bread items',
    },
    {
      'url': 'assets/images/banner/pizza3.jpg',
      'text': 'non-veg items',
    },
    {
      'url': 'assets/images/banner/pizza1.jpeg',
      'text': 'pizza',
    },
    {
      'url': 'assets/images/banner/banner2.jpeg',
      'text': 'starters',
    },
  ];

  CategoryListing({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: avatarData.length,
        itemBuilder: (context, index) {
          final avatarUrl = avatarData[index]['url'];
          final text = avatarData[index]['text'];

          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 5),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    context
                        .read<CategoryBloc>()
                        .add(FetchCategoryProducts(text!));

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductList(
                          title: text,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 40, // Adjust the size of the avatar
                    backgroundImage: AssetImage(avatarUrl!),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  text!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
