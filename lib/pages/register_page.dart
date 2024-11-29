import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_textfield.dart';
import 'package:flutter_application_1/pages/home_page.dart'; // Pastikan ini diubah ke lokasi file HomePage Anda

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

  void register() async {
    // Tampilkan loading dialog
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Validasi input
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty || confirmPwController.text.trim().isEmpty || usernameController.text.trim().isEmpty) {
      if (mounted) Navigator.pop(context); // Tutup loading dialog
      _displayMessageToUser("Please fill in all fields", context);
      return;
    }

    if (passwordController.text != confirmPwController.text) {
      if (mounted) Navigator.pop(context); // Tutup loading dialog
      _displayMessageToUser("Passwords do not match!", context);
      return;
    }

    try {
      // Proses registrasi Firebase
      UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Simpan data ke Firestore
      await createUserDocument(userCredential);

      if (mounted) {
        Navigator.pop(context); // Tutup loading dialog
        // Navigasi ke halaman HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) Navigator.pop(context); // Tutup loading dialog
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = "This email is already registered.";
          break;
        case 'invalid-email':
          message = "The email address is invalid.";
          break;
        case 'weak-password':
          message = "The password is too weak.";
          break;
        default:
          message = e.message ?? "An unknown error occurred.";
      }
      _displayMessageToUser(message, context);
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance.collection("Users").doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
    }
  }

  void _displayMessageToUser(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
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
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Arahkan ke halaman lupa password
                  },
                  child: Text(
                    "Forget Password",
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
                const SizedBox(height: 25),
                MyButton(
                  text: "Register",
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
