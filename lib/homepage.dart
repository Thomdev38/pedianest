import 'package:flutter/material.dart';
import 'package:pedianesth/english/mainen.dart';

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
                const EdgeInsets.only(top: 60, bottom: 20, right: 20, left: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text("Simple"),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  child: const Text('English'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Mainen()),
                    );
                  },
                ),
              ],
            )));
  }
}
