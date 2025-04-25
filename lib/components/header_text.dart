import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Image.asset(
            'assets/images/waffol.jpg', // Replace with your actual image path
            fit: BoxFit.cover,
          ),
        ),

        // Overlay content: logo + YumPlan text
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Colors.black.withOpacity(0.4),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Optional Logo in Red Circle
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFB71C1C), // Deep red
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/Paella.png', // Replace with your logo path
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(height: 16),

                // YumPlan Title
                const Text(
                  'YumPlan',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Cursive', // Optional if you have a custom font
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
