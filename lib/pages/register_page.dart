import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_textfield.dart';
import 'package:flutter_application_1/pages/home_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  bool _isLoading = false;

  // Fungsi untuk menampilkan pesan kepada user
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> register() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Validasi input
    if (usernameController.text.trim().isEmpty || emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty || confirmPwController.text.trim().isEmpty) {
      if (mounted) _showMessage("Please fill in all fields.");
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    if (passwordController.text != confirmPwController.text) {
      if (mounted) _showMessage("Passwords do not match!");
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      // Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Firestore
      await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.uid).set({
        'username': usernameController.text.trim(),
        'email': emailController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "This email is already registered.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is invalid.";
          break;
        case 'weak-password':
          errorMessage = "The password is too weak.";
          break;
        default:
          errorMessage = "An unexpected error occurred: ${e.message}";
      }
      if (mounted) _showMessage(errorMessage);
    } catch (e) {
      if (mounted) _showMessage("An unexpected error occurred. Please try again.");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(height: 25),
                const Text(
                  "M I N I M A L",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 50),
                MyTextfield(
                  hinText: "Username",
                  obsucreText: false,
                  controller: usernameController,
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  hinText: "Email",
                  obsucreText: false,
                  controller: emailController,
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  hinText: "Password",
                  obsucreText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  hinText: "Confirm Password",
                  obsucreText: true,
                  controller: confirmPwController,
                ),
                const SizedBox(height: 25),
                MyButton(
                  text: _isLoading ? "Registering..." : "Register",
                  onTab: register,
                ),
                const SizedBox(height: 25),
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
