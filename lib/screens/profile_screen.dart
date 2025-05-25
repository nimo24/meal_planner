import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color mainColor = Color(0xFFE55063);
  final Color bgColor = Color(0xFFF9FAFC);

  // Displayed user info
  String displayedName = "Loading...";
  String displayedEmail = "Loading...";

  // Editable fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      setState(() {
        displayedEmail = user.email ?? "";
        displayedName = user.userMetadata?['name'] ?? "User";
      });
    }
  }

  Future<void> _updateUserData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    try {
      // Update name in user_metadata
      if (nameController.text.isNotEmpty) {
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(data: {'name': nameController.text}),
        );
        displayedName = nameController.text;
      }

      // Update email
      if (emailController.text.isNotEmpty) {
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(email: emailController.text),
        );
        displayedEmail = emailController.text;
      }

      // Update password
      if (passwordController.text.isNotEmpty) {
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(password: passwordController.text),
        );
      }

      // Refresh UI
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
   
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: mainColor,
                child: CircleAvatar(
                  radius: 47,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ),
              SizedBox(height: 16),
              Text(displayedName, style: TextStyle(fontSize: 22, color: mainColor, letterSpacing: 2)),
              Text(displayedEmail, style: TextStyle(color: Colors.grey[600])),
              SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    buildEditableField(Icons.account_box, "Update Name", nameController),
                    SizedBox(height: 15),
                    buildEditableField(Icons.mail_outline, "Update Email", emailController),
                    SizedBox(height: 15),
                    buildEditableField(Icons.lock_outline, "Update Password", passwordController, isPassword: true),
                  ],
                ),
              ),

              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: _updateUserData,
                child: Text("Save changes", style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(IconData icon, String label, TextEditingController controller, {bool isPassword = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    obscureText: isPassword,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: label,
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Icon(Icons.mode_edit_outline_outlined, color: Colors.indigo, size: 20),
        ),
      ],
    );
  }
}
