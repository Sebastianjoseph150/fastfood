import 'package:fastfood/screens/cart/cart_screen.dart';
import 'package:fastfood/screens/fav/fav_page.dart';
import 'package:fastfood/screens/orderlisting/oreder_listing.dart';
import 'package:fastfood/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastfood/bloc/navigation bar/bloc/navigation_bloc.dart';
import 'package:fastfood/screens/home_screen/home_screen.dart';

import '../profile/profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateToSearchScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final NavigationBloc navigationBloc =
        BlocProvider.of<NavigationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          'Fast food',
          style: TextStyle(
              color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 28),
        )),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _navigateToSearchScreen(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'Fast food',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('whishlist'),
              titleAlignment: ListTileTitleAlignment.titleHeight,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteListPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('my orders'),
              titleAlignment: ListTileTitleAlignment.titleHeight,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderListingPage(
                              key: key,
                            ))); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          Widget page;
          if (state is HomeScreenState) {
            page = const HomeScreen();
          } else if (state is CartScreenState) {
            page = const CartPage(
              cartItems: [],
            );
          } else if (state is ProfileScreenState) {
            page = const AdditionalInformation();
          } else {
            page = const HomeScreen();
          }

          return page;
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          int currentIndex = 0;

          if (state is HomeScreenState) {
            currentIndex = 0;
          } else if (state is CartScreenState) {
            currentIndex = 1;
          } else if (state is ProfileScreenState) {
            currentIndex = 2;
          }

          return BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              NavigationEvent event;
              switch (index) {
                case 0:
                  event = NavigateToHomeEvent();
                  break;
                case 1:
                  event = NavigateToCartEvent();
                  break;
                case 2:
                  event = NavigateToProfileEvent();
                  break;
                default:
                  event = NavigateToHomeEvent();
              }
              navigationBloc.add(event);
            },
            selectedItemColor: Colors.orange,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
