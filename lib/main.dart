import 'package:c2g/screens/login_screen.dart';
import 'package:c2g/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'C2G',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        LoginScreen.routeName: (context)=>LoginScreen(),
        SignupScreen.routeName: (context)=>const SignupScreen(),
      },
      home: LoginScreen(),
    );
  }
}
