import 'package:flutter/material.dart';

class ComplaintCard extends StatelessWidget {
  const ComplaintCard({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: 200,
      width: mediaQuery.size.width * 0.9,
      color: Colors.red,
      // TODO: 
      child: const Center(child: Text("Complaint Card")),
    );
  }
}
