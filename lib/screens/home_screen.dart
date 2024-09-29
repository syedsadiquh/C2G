import 'package:c2g/components/complaint_card.dart';
import 'package:flutter/material.dart';

import '../components/user_drawer.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/user/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "C2G",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(6.0),
              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Theme.of(context).primaryColor),
                    foregroundColor:
                        const WidgetStatePropertyAll(Colors.white)),
                icon: const Icon(Icons.menu),
              ),
            ),
          ),
        ),
        drawer: const UserDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: Center(
          // TODO... Query from Firestore DB
          child: ComplaintCard(),
        ));
  }
}
