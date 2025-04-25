import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                   'assets/images/waffol.jpg'), // 🔁 Your image here
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Semi-transparent overlay for blur effect
          Container(
            color: Colors.black.withOpacity(0.3),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  // Logo
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage('assets/images/logo.png'), // 🔁 Your logo
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "YumPlan",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Cursive',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Glass container
                  Container(
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        // Toggle between login/signup
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() => isLogin = true);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    isLogin ? Colors.black : Colors.white,
                                backgroundColor:
                                    isLogin ? Colors.white : Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text("Login"),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                setState(() => isLogin = false);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    !isLogin ? Colors.black : Colors.white,
                                backgroundColor: !isLogin
                                    ? Colors.white
                                    : Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text("Sign Up"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Conditional Name field
                        if (!isLogin)
                          TextField(
                            controller: _nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: inputDecoration("Name"),
                          ),
                        if (!isLogin) const SizedBox(height: 12),

                        TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: inputDecoration("Email"),
                        ),
                        const SizedBox(height: 12),

                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: inputDecoration("Password"),
                        ),
                        const SizedBox(height: 24),

                        // Action button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: const Color.fromARGB(221, 72, 70, 70),
                          ),
                          onPressed: () {
                            if (isLogin) {
                              // TODO: handle login
                            } else {
                              // TODO: handle sign up
                            }
                          },
                          child: Text(
                            isLogin ? "Login" : "Sign Up",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),

                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            setState(() => isLogin = !isLogin);
                          },
                          child: Text(
                            isLogin
                                ? "Forget password?"
                                : "You already have an account?",
                            style: const TextStyle(color: Colors.white70),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.white30),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.white),
      ),
      fillColor: Colors.white.withOpacity(0.1),
      filled: true,
    );
  }
}
