import 'package:c2g/src/auth_service.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatefulWidget {
  const UserDrawer({super.key});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  var authService = AuthService();
  var name = "", email = "";

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Drawer(
      child: Column(
        children: [
          // Top Header for user info
          Container(
            height: mediaQuery.size.height * 0.2,
            width: mediaQuery.size.width,
            color: const Color.fromRGBO(234, 221, 255, 100),
            child: Padding(
              // for keeping the distance from edge
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Bottom
                crossAxisAlignment: CrossAxisAlignment.start, // Left
                children: [
                  Text(
                    "Welcome, $name",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(email),
                ],
              ),
            ),
          ),

          // Material Icon for viewing profile
          MaterialButton(
            onPressed: () {}, // TODO: Add a Profile Screen.
            child: const Row(
              children: [
                Icon(Icons.person_2_outlined),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getUserDetails() {
    var id = authService.auth.currentUser?.uid;
    authService.firestore.collection('users').get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc.id == id) {
          setState(() {
            name = doc.data()['name'];
            email = doc.data()['email'];
          });
        }
      }
    }, onError: (e) => print("Error Fetching data from Firestore"));
  }
}
