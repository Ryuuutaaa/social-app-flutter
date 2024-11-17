import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // looogo
            Icon(
              Icons.person,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            const SizedBox(
              height: 25,
            ),

            // app name
            const Text(
              "M I N I M A L",
              style: TextStyle(fontSize: 25),
            ),

            // email textfield

            // password textfiedl

            // forget password

            // signt button

            // dont have account? register now
          ],
        ),
      ),
    );
  }
}
