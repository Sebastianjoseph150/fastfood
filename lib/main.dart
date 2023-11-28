import 'package:fastfood/bloc/Address/bloc/address_bloc.dart';
import 'package:fastfood/bloc/authbloc/auth_bloc.dart';
import 'package:fastfood/bloc/bloc/favorite/fav_bloc.dart';
import 'package:fastfood/bloc/bloc/featured_dish_bloc.dart';
import 'package:fastfood/bloc/cart/bloc/cart_bloc.dart';
import 'package:fastfood/bloc/category/category_bloc.dart';
import 'package:fastfood/bloc/order/bloc/order_bloc.dart';
import 'package:fastfood/bloc/restauant/bloc/check_out/bloc/check_out_bloc.dart';
import 'package:fastfood/bloc/restauant/bloc/restaurant_bloc.dart';
import 'package:fastfood/bloc/search/bloc/search_bloc.dart';
import 'package:fastfood/repository/Address/address_repository.dart';
import 'package:fastfood/repository/FeaturedDishesRepository/featured_Dishes_Repo.dart';
import 'package:fastfood/repository/Order/order_repo.dart';
import 'package:fastfood/repository/cart/cart_repository.dart';
import 'package:fastfood/repository/category_repository.dart';
import 'package:fastfood/repository/favorite/favorite_repo.dart';
import 'package:fastfood/repository/nav_repository/nav_repository.dart';
import 'package:fastfood/repository/auth_repository.dart';
import 'package:fastfood/repository/restaurent%20iteams/reastaurent_iteams_repo.dart';
import 'package:fastfood/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/navigation bar/bloc/navigation_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider<NavigationBloc>(
            create: (context) => NavigationBloc(
              navRepo: NavRepo(), // You can create an instance of NavRepo here
            ),
          ),
          BlocProvider<FeaturedDishesBloc>(
              create: (context) => FeaturedDishesBloc(
                    featuredDishesRepository: FeaturedDishesRepository(),
                  )),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(
              cartRepository: CartRepository(),
            ),
          ),
          BlocProvider<CategoryBloc>(
            create: (context) =>
                CategoryBloc(categoryRepository: CategoryRepository()),
          ),
          BlocProvider<RestaurantBloc>(
            create: (context) =>
                RestaurantBloc(restaurentRepo: RestaurentRepo()),
          ),
          BlocProvider<AddressBloc>(
            create: (context) =>
                AddressBloc(addressRepository: AddressRepository()),
          ),
          BlocProvider(
            create: (context) =>
                SearchBloc(RestaurentRepo(), FeaturedDishesRepository()),
          ),
          BlocProvider<FavoriteBloc>(
              create: (context) =>
                  FavoriteBloc(favoriteRepository: FavoriteRepository())),
          BlocProvider<CheckOutBloc>(
            create: (context) => CheckOutBloc(
                CartRepository(), AddressRepository(), OrderRepository()),
          ),
          BlocProvider<OrderBloc>(
            create: (context) => OrderBloc(
              orderRepository: OrderRepository(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
