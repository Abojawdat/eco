import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/pages/home_screen.dart';
import 'package:untitled/pages/product_screen.dart';
import './auth/login.dart';
import './cuibit/categori_cubit.dart';
import './cuibit/product_cubit.dart';
import './cuibit/login_cubit.dart';
import './services/token_cheaker.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => CategoryCubit()..loadCategories()),
        BlocProvider(create: (_) => ProductCubit()),
      ],
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
      theme: ThemeData(fontFamily: 'Cairo'),
      initialRoute: 'launcher',
      routes: {
        'launcher': (context) => const LauncherPage(),  // New launcher page
        'home': (context) => const homescreen(),
        'login': (context) => const LoginPage(),
        'productscreen': (context) => ProductScreen(),
      },

    );
  }
}
