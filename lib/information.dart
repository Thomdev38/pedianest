import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Informations"),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(
                    top: 50, left: 50, right: 50, bottom: 50),
                // ignore: prefer_const_constructors
                child: Column(
                  children: const [
                    Text(
                        "Cette application a été écrite en lien avec les recommandations de la SFAR et de la prise en charge recommandé par les différentes organisation scientifiques notamment France USA Suisse. Pedianest n'est qu'un support d'aide à la prise en charge et l'auteur et développeur ne peut être tenu responsable de problème de dosage ou autres. Seul le professionel est responsable de ses actes. "),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Lien vers l'association les petits doudous"),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ))));
  }
}
