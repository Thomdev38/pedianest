import 'package:flutter/material.dart';

class Divers extends StatefulWidget {
  const Divers({super.key});

  @override
  State<Divers> createState() => _DiversState();
}

class _DiversState extends State<Divers> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: 
        Column(
          children: [
          Text("Privacy policie"),
          Text("Sources ")
        ],)
      )
    );
  }
}
