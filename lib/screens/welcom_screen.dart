import 'package:dealy_meal/components/header_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  // <-- import here
import 'auth_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const HeaderText(),

          // Positioned text/button at bottom
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Text(
                  'Meal planning made simple!\n'
                  'Organize your meals, generate plans,\n'
                  'and save them with ease. Let\'s get started!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lustria(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AuthScreen.routeName);
                  },
                  child: Text(
                    'Get Started!',
                    style: GoogleFonts.lustria(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // "YumPlan" text centered in the middle (adjust placement if needed)
          Center(
            child: Text(
              "YumPlan",
              style: GoogleFonts.licorice(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
