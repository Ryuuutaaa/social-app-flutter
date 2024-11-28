import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers
  final TextEditingController usernamelController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  // Register method
  void register() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Check if fields are empty
    if (emailController.text.isEmpty || passwordController.text.isEmpty || confirmPwController.text.isEmpty || usernamelController.text.isEmpty) {
      Navigator.pop(context);
      _displayMessageToUser("Please fill in all fields", context);
      return;
    }

    // Check if passwords match
    if (passwordController.text != confirmPwController.text) {
      Navigator.pop(context);
      _displayMessageToUser("Passwords do not match!", context);
      return;
    }

    // Try creating the user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Pop loading screen
      Navigator.pop(context);
      _displayMessageToUser("Account created successfully!", context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      // Display error message
      _displayMessageToUser(e.message ?? "An error occurred", context);
    }
  }

  // Display a message to the user
  void _displayMessageToUser(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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

                // Username textfield
                MyTextfield(
                  hinText: "Username",
                  obsucreText: false,
                  controller: usernamelController,
                ),

                const SizedBox(height: 10),

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
                  obsucreText: true,
                  controller: passwordController,
                ),

                const SizedBox(height: 10),

                // Confirm password textfield
                MyTextfield(
                  hinText: "Confirm Password",
                  obsucreText: true,
                  controller: confirmPwController,
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

                // Register button
                MyButton(
                  text: "Register",
                  onTab: register,
                ),

                const SizedBox(height: 25),

                // Already have an account?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        " Login here",
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
