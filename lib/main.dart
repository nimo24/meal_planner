import 'dart:convert';

import 'package:dealy_meal/models/ScheduledMeal.dart';
import 'package:dealy_meal/models/comment_model.dart';
import 'package:dealy_meal/screens/auth_screen.dart';
import 'package:dealy_meal/screens/main_navigation.dart';
import 'package:dealy_meal/screens/profile_screen.dart';
import 'package:dealy_meal/screens/welcom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
   await Supabase.initialize(
    url: 'https://jdzdmisekvnwpbstkqvl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpkemRtaXNla3Zud3Bic3RrcXZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc5NDE5NjgsImV4cCI6MjA2MzUxNzk2OH0.Ao4F615ZCWlrFUSsR0MTEoY4znlhFAtDtS_Ny7bIyy4',
  );

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
     home: const WelcomeScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => const AuthScreen(), // 👈 Add route here
       
      },
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
