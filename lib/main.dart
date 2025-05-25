import 'package:dealy_meal/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/meal_model.dart';
import 'screens/explore_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MealAdapter());
  await Hive.openBox('favourites');
  Hive.registerAdapter(CommentAdapter());
  await Hive.openBox<Comment>('commentsBox');
    // TEMP: Clear old comments for schema reset
  await Hive.box<Comment>('commentsBox').clear();




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
      home: ExplorePage(),
    );
  }
}
