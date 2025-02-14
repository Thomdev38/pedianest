import 'package:flutter/material.dart';
import 'package:pedianesth/information.dart';
import 'package:pedianesth/policie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pedianesth/sources.dart';

class Divers extends StatefulWidget {
  const Divers({super.key});

  @override
  State<Divers> createState() => _DiversState();
}

class _DiversState extends State<Divers> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                          height: height / 8,
                          width: width / 3,
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
                            child: const Text(
                              'Informations',
                              style: TextStyle(fontSize: 12),
                            ),
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
                          height: height / 8,
                          width: width / 3,
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
                            child: const Text(
                              'Sources',
                              style: TextStyle(fontSize: 12),
                            ),
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
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Policie()),
                        );
                      },
                      child: const Text("Politique de confidentialié"),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: _sendEmail,
                              child: const Text("Contactez moi"),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: _openWebsite,
                              child: const Text("Deviade.fr"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ))));
  }

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'thomas.deviade@gmail.com', // Remplace par l'adresse cible
      query: 'subject=Application Pedianesth', // Sujet et corps du mail
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      const Text("Impossible d'ouvrir l'application mail.");
    }
  }

  void _openWebsite() async {
    final Uri url = Uri.parse("http://www.deviade.fr");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      const Text("Impossible d'ouvrir le site web.");
    }
  }
}
