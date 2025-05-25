import 'package:dealy_meal/components/meal_card.dart';
import 'package:dealy_meal/screens/mea_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

import '../models/meal_model.dart';

import 'package:google_fonts/google_fonts.dart';



class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<Meal> allMeals = [];
  String selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    loadMeals();
  }

  Future<void> loadMeals() async {
    final String jsonString = await rootBundle.loadString('assets/data/meals.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);

    setState(() {
      allMeals = jsonResponse.map((meal) => Meal.fromJson(meal)).toList();
    });
  }

  List<Meal> get popularMeals =>
      allMeals.where((meal) => meal.isFavourite).toList();

  List<Meal> get availableMeals {
    if (selectedCategory == 'all') return allMeals;
    return allMeals.where((meal) => meal.type == selectedCategory).toList();
  }

  Widget categoryTab(String label) {
    final bool isSelected = selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;

        });
      },
      child: RotatedBox(
        quarterTurns: -1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Color(0xFF774E4E) : Color.fromARGB(151, 119, 78, 78),
              fontSize: isSelected ? 16 : 14,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 45,
            color: const Color.fromARGB(149, 220, 231, 231),
            child:Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    categoryTab('all'),
    const SizedBox(height: 30),
    categoryTab('entree'),
    const SizedBox(height: 30),
    categoryTab('plat'),
    const SizedBox(height: 30),
    categoryTab('dessert'),
  ],
),

          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 40, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Explore page",
                     style: GoogleFonts.nanumMyeongjo(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  ),
                  ),
                   Text(
                    "discover nutritious food recipes",
style: GoogleFonts.patrickHand(
    fontSize: 13,
  
    color: Color.fromARGB(255, 160, 141, 141)
  ),                  ),
                  const SizedBox(height: 20),
                   Text(
                    "POPULAR",
                     style: GoogleFonts.juliusSansOne(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
                  ),
                  const SizedBox(height: 10),
                 SizedBox(
  height: 270,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: popularMeals.length,
    itemBuilder: (context, index) {
      return Container(
        width: 169, // smaller width
        margin: const EdgeInsets.only(right: 12),
        child: GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(meal: popularMeals[index]),
      ),
    );
  },
  child: MealCard(meal: popularMeals[index]),
),

      );
    },
  ),
),


                  const SizedBox(height: 20),
                  Text(
  "AVAILABLE PLATES",
  style: GoogleFonts.juliusSansOne(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: availableMeals.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 270,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(meal: availableMeals[index]),
      ),
    );
  },
  child: MealCard(meal: availableMeals[index]),
);

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 0,
        onTap: (index) {
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
