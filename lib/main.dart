import 'package:flutter/material.dart';
import 'screens/welcom_screen.dart';
import 'screens/auth_screen.dart'; // 👈 Import the AuthScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YumPlan',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => const AuthScreen(), // 👈 Add route here
      },
    );
  }
}
