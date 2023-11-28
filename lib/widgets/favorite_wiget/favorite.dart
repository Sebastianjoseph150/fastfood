import 'package:fastfood/bloc/bloc/favorite/fav_bloc.dart';
import 'package:fastfood/models/usermodel/featured_dish.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatefulWidget {
  final String item;
  final FeaturedDish dish;

  const FavoriteButton({super.key, required this.item, required this.dish});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late FavoriteBloc favoriteBloc;

  @override
  void initState() {
    super.initState();
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);

    favoriteBloc.add(CheckFavorite(widget.item));

    favoriteBloc.stream.listen((state) {
      if (state is FavoriteLoaded) {
        final isFavorite = state.isFavorite;
        setState(() {
          isItemFavorite = isFavorite;
        });
      }
    });
  }

  bool isItemFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: IconButton(
        icon: Icon(
          Icons.favorite,
          size: 32,
          color: isItemFavorite ? Colors.red : Colors.grey,
        ),
        onPressed: () {
          context.read<FavoriteBloc>().add(
                ToggleFavorite(widget.item, widget.dish),
              );
          // context.read<FavoriteBloc>().add(FetchFaviteams());
        },
      ),
    );
  }
}
