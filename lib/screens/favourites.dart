import 'package:dealy_meal/components/meal_card.dart';
import 'package:dealy_meal/screens/mea_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

import '../models/meal_model.dart';

import 'package:google_fonts/google_fonts.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<Meal> favouriteMeals = [];

  @override
  void initState() {
    super.initState();
    loadFavourites();
  }

  Future<void> loadFavourites() async {
    final String jsonString = await rootBundle.loadString('assets/data/meals.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);

    setState(() {
      // Only keep meals where isFavourite == true
      favouriteMeals = jsonResponse
          .map((meal) => Meal.fromJson(meal))
          .where((meal) => meal.isFavourite)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourites",
          style: GoogleFonts.nanumMyeongjo(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown[200],
      ),
      body: favouriteMeals.isEmpty
          ? Center(
              child: Text(
                "No favourite meals found.",
                style: GoogleFonts.patrickHand(fontSize: 18),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favouriteMeals.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 270,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final meal = favouriteMeals[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(meal: meal),
                      ),
                    );
                  },
                  child: MealCard(meal: meal),
                );
              },
            ),
    );
  }
}
