import 'package:flutter/material.dart';

class Homefrench extends StatefulWidget {
  const Homefrench({super.key});

  @override
  State<Homefrench> createState() => _HomefrenchState();
}

class _HomefrenchState extends State<Homefrench> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
            child: (const Text("texte de la page francais"))));
  }
}
