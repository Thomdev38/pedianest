import 'package:flutter/material.dart';
import 'package:pedianesth/english/mainen.dart';
import 'package:pedianesth/french/homepagefr.dart';
import 'package:pedianesth/french/mainfr.dart';
import 'package:pedianesth/main.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        body: Container(
            padding:
                const EdgeInsets.only(top: 60, bottom: 20, right: 20, left: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Francais'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Mainfr()),
                    );
                  },
                ),
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
