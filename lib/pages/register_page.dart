import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/my_button.dart';
import 'package:flutter_application_1/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  // controller
  final TextEditingController usernamelController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  // register method
  void register() {}

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

              // username textfield
              MyTextfield(hinText: "Username", obsucreText: false, controller: usernamelController),

              const SizedBox(
                height: 10,
              ),

              MyTextfield(hinText: "Email", obsucreText: false, controller: emailController),

              const SizedBox(
                height: 10,
              ),

              // password textfiedl
              MyTextfield(hinText: "Password", obsucreText: false, controller: passwordController),

              const SizedBox(
                height: 10,
              ),

              // confirm password
              MyTextfield(hinText: "Confirm Password", obsucreText: false, controller: confirmPwController),

              const SizedBox(
                height: 10,
              ),

              // forget password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forget Password",
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  )
                ],
              ),

              const SizedBox(
                height: 25,
              ),

              // signt button
              MyButton(
                text: "Register",
                onTab: register,
              ),

              const SizedBox(height: 25),

              // dont have account? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Login here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}