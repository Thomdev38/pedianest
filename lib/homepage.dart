import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
            child: (const Text(
              "text page accueil",
            ))));
  }
}
