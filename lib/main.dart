import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/home_screen.dart';
import './auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Abojawdat app ",
      theme: ThemeData(
        fontFamily: 'Cairo',
      ),
      initialRoute: 'login',
      routes: {
        'home': (context) => const homescreen(),
        'login': (context) => const LoginPage(),
      },
    );
  }
}