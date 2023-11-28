import 'package:fastfood/bloc/restauant/bloc/restaurant_bloc.dart';
import 'package:fastfood/models/usermodel/Restaurent/restaurent.dart';
import 'package:fastfood/screens/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          context
              .read<RestaurantBloc>()
              .add(FetchProductsByRestaurant(restaurentname: restaurant.name));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => MenuPage(
                    restaurant: restaurant.name,
                  )),
            ),
          );
        },
        child: Card(
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 135,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  ),
                  child: Image.network(
                    restaurant.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
                child: Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Cuisine: ${restaurant.description}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:fastfood/bloc/restauant/bloc/restaurant_bloc.dart';
// import 'package:fastfood/models/usermodel/Restaurent/restaurent.dart';
// import 'package:fastfood/screens/menu/menu_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get_navigation/get_navigation.dart';

// class RestaurantCard extends StatelessWidget {
//   final Restaurant restaurant;

//   const RestaurantCard({Key? key, required this.restaurant}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: BlocListener<RestaurantBloc, RestaurantState>(
//         listener: (context, state) {},
//         child: InkWell(
//           onTap: () {
//             context.read<RestaurantBloc>().add(
//                 FetchProductsByRestaurant(restaurentname: restaurant.name));
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: ((context) => MenuPage(
//                           restaurant: restaurant.name,
//                         ))));
//           },
//           child: Card(
//             elevation: 3,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 135,
//                   width: double.infinity,
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(4.0),
//                       topRight: Radius.circular(4.0),
//                     ),
//                     child: Image.network(
//                       restaurant.imageUrl,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 2, 2, 2),
//                   child: Text(
//                     restaurant.name,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Text(
//                     'Cuisine: ${restaurant.description}',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
