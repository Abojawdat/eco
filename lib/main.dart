import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/home_screen.dart';
import './auth/login.dart';
import './cuibit/categori_cubit.dart';


void main() {
  runApp(
    BlocProvider(
      create: (_) => CategoryCubit()..loadCategories(),
      child: const MyApp(),
    ),
  );
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
      initialRoute: 'home',
      routes: {
        'home': (context) => const homescreen(),
        'login': (context) => const LoginPage(),
      },
    );
  }
}