import 'package:flutter/material.dart';

class Fiches extends StatefulWidget {
  const Fiches({super.key});

  @override
  State<Fiches> createState() => _FichesState();
}

class _FichesState extends State<Fiches> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("fiches reflexe"),
    );
  }
}
