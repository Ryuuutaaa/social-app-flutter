import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to display messages to the user
  void _displayMessageToUser(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Login function
  void login() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Validate inputs
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Navigator.pop(context);
      _displayMessageToUser("Please fill in all fields", context);
      return;
    }

    try {
      // Attempt to sign in
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Pop loading circle
      if (context.mounted) Navigator.pop(context);

      // Optionally, navigate to a new screen after successful login
      _displayMessageToUser("Login successful!", context);
    } on FirebaseAuthException catch (e) {
      // Pop loading circle
      if (context.mounted) Navigator.pop(context);

      // Display error message
      _displayMessageToUser(e.message ?? "An error occurred", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(height: 25),

                // App name
                const Text(
                  "M I N I M A L",
                  style: TextStyle(fontSize: 25),
                ),

                const SizedBox(height: 50),

                // Email textfield
                MyTextfield(
                  hinText: "Email",
                  obsucreText: false,
                  controller: emailController,
                ),

                const SizedBox(height: 10),

                // Password textfield
                MyTextfield(
                  hinText: "Password",
                  obsucreText: true, // Password field is now hidden
                  controller: passwordController,
                ),

                const SizedBox(height: 10),

                // Forget password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forget Password",
                      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // Login button
                MyButton(
                  text: "Login",
                  onTab: login,
                ),

                const SizedBox(height: 25),

                // Don't have an account? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        " Register here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
