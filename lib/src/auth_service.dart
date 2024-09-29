import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/home_screen.dart';

class AuthService {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final pwdTextController = TextEditingController();

  Future<bool> login(BuildContext context) async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: emailTextController.text, password: pwdTextController.text)
          .then((value) {
        // showing the login message to user
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Login Successful")));
        }

        // Pushing them to the HomeScreen after login.
        if (auth.currentUser != null && context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid Credentials")));
        }
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<Map<String, String>> signup(
      BuildContext context, Map<String, String> data) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: data['email']!,
        password: pwdTextController.text,
      )
          .then((value) async {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Successful")));
        }

        // TODO: Store in Firestore DB
        firestore
            .collection('users')
            .doc(auth.currentUser?.uid)
            .set(data)
            .onError((e, _) {
          print("Unable to upload to User Database");
          return;
        });

        if (auth.currentUser != null && context.mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        }
      });
    } on FirebaseAuthException catch (e, _) {
      print(e);
      // print(_);
      if (e.code == 'weak-password') {
        return <String, String>{
          "err": "password",
          "err_text": "Weak Password",
          "bool_res": "false"
        };
      } else if (e.code == 'email-already-in-use') {
        return <String, String>{
          "err": "email",
          "err_text": "Email already in use",
          "bool_res": "false"
        };
      }
    } catch (e) {
      print(e);
    }

    return {'err': "none"};
  }

  Future<void> signout(BuildContext context) async {
    {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (route) => false,
        );
      }
    }
  }
}
