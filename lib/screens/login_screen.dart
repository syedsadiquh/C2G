import 'package:c2g/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/login-screen';
  LoginScreen({super.key});

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                "./lib/assets/images/login_image.jpg",
                height: 300,
              ),
              const Text(
                "Login to your",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const Text(
                "Citizen Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // Username Text field for entering the username/email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Password Text field for entering the username/email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: _passController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              // button to perform the Login process
              ElevatedButton(
                onPressed: () {},  // TODO: Implement the login functionality
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primaryContainer),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 40),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 14),
                ),
              ),

              // Signup text button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not Registered?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignupScreen.routeName);
                    },
                    child: Text("Signup Now"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
