import 'package:flutter/material.dart';
import 'screens/welcom_screen.dart';
import 'screens/auth_screen.dart'; // 👈 Import the AuthScreen
import 'package:supabase_flutter/supabase_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jdzdmisekvnwpbstkqvl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpkemRtaXNla3Zud3Bic3RrcXZsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc5NDE5NjgsImV4cCI6MjA2MzUxNzk2OH0.Ao4F615ZCWlrFUSsR0MTEoY4znlhFAtDtS_Ny7bIyy4',
  );
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

