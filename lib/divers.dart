import 'package:flutter/material.dart';

class Divers extends StatefulWidget {
  const Divers({super.key});

  @override
  State<Divers> createState() => _DiversState();
}

class _DiversState extends State<Divers> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: 
        const Column(
          
          children: [
          Text("Privacy policie"),
          Text("Sources "),
        ],)
      )
    ));
  }
}
