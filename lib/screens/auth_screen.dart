import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';

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

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/waffol.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay
          Container(
            color: Colors.black.withOpacity(0.3),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFFB71C1C),
                    backgroundImage: AssetImage('assets/images/Paella.png'),
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

                  Container(
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        // Tabs
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => setState(() => isLogin = true),
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
                              onPressed: () => setState(() => isLogin = false),
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    !isLogin ? Colors.black : Colors.white,
                                backgroundColor:
                                    !isLogin ? Colors.white : Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text("Sign Up"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

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

                        _isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                  backgroundColor:
                                      const Color.fromARGB(221, 72, 70, 70),
                                ),
                                onPressed: handleAuthAction,
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

  Future<void> handleAuthAction() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final supabase = Supabase.instance.client;

    setState(() => _isLoading = true);

    try {
      if (isLogin) {
        final response = await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
        if (response.user != null) {
          _navigateToProfile();
        }
      } else {
        final response = await supabase.auth.signUp(
          email: email,
          password: password,
          data: {'name': name},
        );
        if (response.user != null /* && response.user!.emailConfirmedAt != null */) {
          _navigateToProfile();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Check your email to verify account.")),
          );
        }
      }
    } on AuthException catch (e) {
      print("AuthException: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unexpected error occurred.")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToProfile() {
    // Clear fields before navigating
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );

    // OR, if using named routes:
    // Navigator.pushReplacementNamed(context, ProfilePage.routeName);
  }
}
