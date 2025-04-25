import 'package:flutter/material.dart';

class Auth1Screen extends StatefulWidget {
  static const routeName = '/auth';

  const Auth1Screen({super.key});

  @override
  State<Auth1Screen> createState() => _Auth1ScreenState();
}

class _Auth1ScreenState extends State<Auth1Screen> {
  final Map<String, String> form = {
    "email": "",
    "password": "",
    "name": "",
  };

  void handleChange(String key, String value) {
    setState(() {
      form[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // gray-100
      body: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            color: Colors.white,
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: const TabBar(
                      indicatorColor: Colors.black,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: 'Login'),
                        Tab(text: 'Sign Up'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 320,
                    child: TabBarView(
                      children: [
                        // Login Form
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              ),
                              onChanged: (value) => handleChange("email", value),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              ),
                              onChanged: (value) => handleChange("password", value),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                              onPressed: () {},
                              child: const Text("Login"),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),

                        // Signup Form
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                                hintText: 'Name',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              ),
                              onChanged: (value) => handleChange("name", value),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              ),
                              onChanged: (value) => handleChange("email", value),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              ),
                              onChanged: (value) => handleChange("password", value),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              ),
                              onPressed: () {},
                              child: const Text("Sign Up"),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Already have an account? Login",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
