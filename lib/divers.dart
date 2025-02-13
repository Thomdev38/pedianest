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
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 150,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue, // Couleur du texte
                              backgroundColor: const Color.fromARGB(
                                  132, 108, 223, 223), // Couleur de fond

                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold), // Style du texte
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Bords arrondis
                              ),
                            ),
                            child: const Text('Informations'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Information()),
                              );
                            },
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 100,
                          width: 150,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue, // Couleur du texte
                              backgroundColor: const Color.fromARGB(
                                  132, 108, 223, 223), // Couleur de fond
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold), // Style du texte
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // Bords arrondis
                              ),
                            ),
                            child: const Text('Sources'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Sources()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text("Privacy policie"),
                  ],
                ))));
  }
}
