import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_screen.dart'; // Make sure this matches your file path

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _signOut(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();

    // Navigate to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );

    // OR using named routes:
    // Navigator.pushReplacementNamed(context, AuthScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 247, 247),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCA183B),
                  ),
                ),
                const Text(
                  'johndoe@example.com',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Update Name',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCA183B)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCA183B)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Update Email',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCA183B)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCA183B)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Change Password',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCA183B)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFCA183B)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCA183B),
                    ),
                    onPressed: () {
                      // TODO: Implement save changes
                    },
                    child: const Text('Save Changes'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFCA183B),
                      side: const BorderSide(color: Color(0xFFCA183B)),
                    ),
                    onPressed: () => _signOut(context),
                    child: const Text('Logout'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
