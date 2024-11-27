import 'package:flutter/material.dart';

class Homeenglish extends StatefulWidget {
  const Homeenglish({super.key});

  @override
  State<Homeenglish> createState() => _HomeenglishState();
}

class _HomeenglishState extends State<Homeenglish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
            child: (const Text("texte de la page"))));
  }
}
