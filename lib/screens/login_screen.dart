import 'package:c2g/screens/signup_screen.dart';
import 'package:c2g/src/auth_service.dart';
import 'package:c2g/src/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = AuthService();

  bool _emailSts = false;
  bool _pwsSts = false;
  bool _isLoading = false;

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
                  controller: authService.emailTextController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    errorText: _emailSts ? "Invalid Email Address" : null,
                    border: const OutlineInputBorder(
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
                  controller: authService.pwdTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    errorText: _pwsSts ? "Password can't be Empty" : null,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),
              // button to perform the Login process
              _isLoading
              // Added Circular Loading Progress bar until the checks are in progress.
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          // Setting the Loading status on the screen to true.. and showing the Loading symbol
                          _isLoading = true;
                          _emailSts = (!Constants.isEmailValid(
                                  authService.emailTextController.text)) ||
                              (authService.emailTextController.text.isEmpty);
                          // If email error status is true, then revert the loading status and stop right there.
                          if (_emailSts) {
                            _isLoading = false;
                            return;
                          }
                          // Getting the Password status of being empty
                          _pwsSts =
                              (authService.pwdTextController.text.isEmpty);
                          // Exiting and not checking the login cred.
                          if (_pwsSts) {
                            _isLoading = false;
                            return;
                          }
                        });
                        var res = await authService.login(context);
                        setState(() {
                          // Setting the status of Loading based on the the status returned by the login function.
                          _isLoading = res;
                        });
                      },
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
                    child: const Text("Signup Now"),
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
