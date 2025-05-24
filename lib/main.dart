import 'dart:convert';

import 'package:dealy_meal/models/ScheduledMeal.dart';
import 'package:dealy_meal/models/comment_model.dart';
import 'package:dealy_meal/screens/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/meal_model.dart';
import 'screens/explore_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MealAdapter());
  await Hive.openBox<Meal>('favourites');
  Hive.registerAdapter(CommentAdapter());
  await Hive.openBox<Comment>('commentsBox');
  // TEMP: Clear old comments for schema reset
  await Hive.box<Comment>('commentsBox').clear();
  Hive.registerAdapter(ScheduledMealAdapter());
  await Hive.openBox<ScheduledMeal>('scheduledMeals');

  await loadMealsFromJson();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainNavigation(),
    );
  }
}

Future<void> loadMealsFromJson() async {
  final box = Hive.box<Meal>('favourites');

  if (box.isEmpty) {
    // Load JSON string from assets
    final String jsonString =
        await rootBundle.loadString('assets/data/meals.json');

    // Decode JSON list
    final List<dynamic> jsonList = json.decode(jsonString);

    // Map JSON to Meal objects
    final List<Meal> meals =
        jsonList.map((jsonItem) => Meal.fromJson(jsonItem)).toList();

    // Add all meals to Hive box
    await box.addAll(meals);

    print('Loaded ${meals.length} meals from JSON into Hive.');
  } else {
    print('Meals already loaded in Hive box.');
  }
}
