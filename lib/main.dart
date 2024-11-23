import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/login_or_register.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/pages/register_page.dart';
import 'package:flutter_application_1/theme/dark_mode.dart';
import 'package:flutter_application_1/theme/light_mode.dart';

import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOrRegister(),
      theme: lightMode, // Tema terang
      darkTheme: darkMode, // Tema gelap
      themeMode: ThemeMode.system, // Mengikuti pengaturan sistem (terang/gelap)
    );
  }
}
