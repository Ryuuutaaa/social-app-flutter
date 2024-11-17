import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  // controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
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

              const SizedBox(
                height: 50,
              ),

              // email textfield
              MyTextfield(hinText: "Email", obsucreText: false, controller: emailController),

              const SizedBox(
                height: 10,
              ),

              // password textfiedl
              MyTextfield(hinText: "Password", obsucreText: false, controller: passwordController)

              // forget password

              // signt button

              // dont have account? register now
            ],
          ),
        ),
      ),
    );
  }
}
