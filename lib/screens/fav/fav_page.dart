import 'dart:convert';

import 'package:fastfood/bloc/bloc/favorite/fav_bloc.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:fastfood/screens/featured_detail/featured_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteListPage extends StatelessWidget {
  const FavoriteListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteBloc>().add(FetchFaviteams());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Favorite Items',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is FavIteamFetching) {
          } else if (state is FavIteamsFetched) {}
        },
        builder: (context, state) {
          if (state is FavIteamFetching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavIteamsFetched) {
            final List<FeaturedDish> favoriteItems = state.fetchediteams;

            return Column(
              children: [
                Expanded(
                  child: favoriteItems.isNotEmpty
                      ? ListView.builder(
                          itemCount: favoriteItems.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        FeaturedDishDetailPage(
                                          featuredDish: favoriteItems[index],
                                        )),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 4,
                                margin: const EdgeInsets.all(8),
                                color: Colors.white,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: MemoryImage(
                                      base64Decode(
                                          favoriteItems[index].imageUrl),
                                    ),
                                  ),
                                  title: Text(
                                    favoriteItems[index].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    favoriteItems[index].restaurant,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      context.read<FavoriteBloc>().add(
                                            ToggleFavorite(
                                              favoriteItems[index].id,
                                              favoriteItems[index],
                                            ),
                                          );
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('No favorite items.'),
                        ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Error loading favorite items.'),
            );
          }
        },
      ),
    );
  }
}
