import 'package:flutter/material.dart';
import 'package:pedianesth/information.dart';
import 'package:pedianesth/sources.dart';

class Divers extends StatefulWidget {
  const Divers({super.key});

  @override
  State<Divers> createState() => _DiversState();
}

class _DiversState extends State<Divers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    const Text("Privacy policie"),
                    TextButton(
                      child: const Text('Sources'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Sources()),
                        );
                      },
                    ),
                    TextButton(
                      child: const Text('Informations'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Information()),
                        );
                      },
                    ),
                  ],
                ))));
  }
}
