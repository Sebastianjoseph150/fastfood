import 'package:fastfood/bloc/search/bloc/search_bloc.dart';

import 'package:fastfood/widgets/search/search_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedDropdownValue = 'Restaurant';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const Center(
              child: Text(
                'Search Results',
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.maxFinite,
                  height: 145,
                  decoration: BoxDecoration(
                    color: Colors
                        .orange, // Change the background color of the container to orange
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.zero, right: Radius.zero),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Search',
                            hintText: 'Search for items...',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                context.read<SearchBloc>().add(ClearSearch());
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.orange, width: 2.0),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            filled: true,
                            fillColor: Colors.grey[
                                200], // Change the background color as needed
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]!),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          onChanged: (value) {
                            context.read<SearchBloc>().add(
                                  PerformSearch(
                                    query: value,
                                    selectedOption: _selectedDropdownValue,
                                  ),
                                );
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                    
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                            child: DropdownButton<String>(
                              value: _selectedDropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedDropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'Restaurant',
                                'Dishes'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          18, // Adjust the font size as needed
                                      fontWeight:
                                          FontWeight.bold, // Make the text bold
                                    ),
                                  ),
                                );
                              }).toList(),
                              style: const TextStyle(
                                  color: Colors.black), // Set text style
                              icon: const Icon(Icons.arrow_drop_down,
                                  color:
                                      Colors.white), // Set dropdown icon color
                              iconDisabledColor: Colors
                                  .grey, // Set dropdown icon color when disabled
                              dropdownColor: Colors
                                  .white10, // Set dropdown background color
                              underline: Container(), // Remove underline
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Search Results',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: SearchResultsList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
