import 'package:c2g/Screens/login_screen.dart';
import 'package:c2g/src/auth_service.dart';
import 'package:c2g/src/constants.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static String routeName = '/signup-screen';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  AuthService authService = AuthService();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _aadhaarTextController = TextEditingController();
  final _pwdTextController = TextEditingController();
  final _cpwdTextController = TextEditingController();

  var _nameValidate = false;
  var _emailValidate = false;
  var _aadhaarValidate = false;
  var _pwdValidate = false;
  var _cpwdValidate = false;

  var _emailErrorString = "Email can't be Empty";
  var _pwdErrorString = "Password should be between 6 - 18";

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
        elevation: 0,
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
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
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
                    controller: _nameTextController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      errorText: _nameValidate ? "Name can't be Empty" : null,
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
                    controller: _emailTextController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      errorText: _emailValidate ? _emailErrorString : null,
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
                    controller: _aadhaarTextController,
                    decoration: InputDecoration(
                      labelText: "Aadhaar Number",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      errorText: _aadhaarValidate ? "Invalid Aadhaar Number" : null,
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
                    controller: _pwdTextController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      errorText: _pwdValidate ? _pwdErrorString : null,

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
                    controller: _cpwdTextController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      errorText: _cpwdValidate ? "Password doesn't match" : null,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),

                // Signup Button
                _isLoading ? const CircularProgressIndicator() : ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Starting the Loading Animation on the Signup button
                      _isLoading = true;
                      // Checking for basic checks for the each input field.
                      _nameValidate = _nameTextController.text.isEmpty;
                      _emailValidate = !Constants.isEmailValid(_emailTextController.text) || _emailTextController.text.isEmpty;
                      _aadhaarValidate = !Constants.isAadhaarValid(_aadhaarTextController.text) || _aadhaarTextController.text.isEmpty;
                      _pwdValidate = !Constants.isPwdValid(_pwdTextController.text);
                      // Checking the Confirm password only if the password is a valid entry.
                      if (!_pwdValidate) {
                        _cpwdValidate = _pwdTextController.text != _cpwdTextController.text;
                      }
                      // Updating the email text if user has entered an email but is invalid.
                      if (_emailValidate && _emailTextController.text.isNotEmpty) {
                        _emailErrorString = "Invalid Email";
                      }

                      _isLoading = !(_nameValidate || _emailValidate || _aadhaarValidate || _pwdValidate || _cpwdValidate);
                    });

                    // TODO: Exclude Password in data for firestore.
                    var data = {
                      "name": _nameTextController.text,
                      "email": _emailTextController.text,
                      "pwd": _pwdTextController.text,
                      "aadhaar": _aadhaarTextController.text,
                    };
                    authService.signup(context, data).then((value) {
                      if (value['err'] == 'email') {
                        setState(() {
                          _emailErrorString = value['err_text']!;
                          _emailValidate = value['bool_res']! as bool;
                          _isLoading = false;
                        });
                      }
                      else if (value['err'] == 'password') {
                        setState(() {
                          _pwdErrorString = value['err_text']!;
                          _pwdValidate = value['bool_res']! as bool;
                          _isLoading = false;
                        });
                      }
                    });
                  }, // TODO: implement the signup functionality
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
                const SizedBox(
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
