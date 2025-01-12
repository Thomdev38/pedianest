import 'package:flutter/material.dart';

class Sources extends StatefulWidget {
  const Sources({super.key});

  @override
  State<Sources> createState() => _SourcesState();
}

class _SourcesState extends State<Sources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sources"),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(100),
                child: const Text("Cette application "))));
  }
}
