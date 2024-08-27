import 'package:c2g/Screens/login_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  static String routeName = '/signup-screen';
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Generate all the TextControllers and use the AuthService Controllers.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        // TODO: Adjust the Icon
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routeName,
                    (route) => false,
              );
            },
            style: ButtonStyle(
              backgroundColor:
              WidgetStatePropertyAll(Theme.of(context).primaryColor),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            icon: Icon(
              Icons.arrow_back,
            )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "./lib/assets/images/signup_image.jpg",
                  height: 230,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Create your Account",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // Name Text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    // controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                // Email Text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    // controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                // Aadhaar Text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    // controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Aadhaar",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                // Password Text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    // controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                // Confirm Password Text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    // controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),

                // Signup Button
                ElevatedButton(
                  onPressed: () {}, // TODO: implement the signup functionality
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.primaryContainer),
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 40),
                    ),
                  ),
                  child: const Text(
                    "Signup",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),

                // Already Registered text and Text-button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Registered?"),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.routeName,
                              (route) => false,
                        );
                      },
                      child: Text("Login"),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
