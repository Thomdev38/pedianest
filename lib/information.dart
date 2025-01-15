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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                        "Voici la liste des ressources scientifiques sur lesquelles sont tirées les données de cette application."),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                        "Le site de l'anesthésie pédiatrique francophone: https://e-adarpef.fr"),
                    SizedBox(
                      height: 8,
                    ),
                    Text("https://sfar.org/recommandations/"),
                    SizedBox(
                      height: 8,
                    ),
                    Text("pedworld.ch"),
                    SizedBox(
                      height: 8,
                    ),
                    Text("https://pedsanesthesia.org/"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                        "Anesthésie pédiatrique de Gilles Orliaguet aux éditions Elsevier Masson"),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                        "Principes et protocoles en anesthésie pédiatrique (4e édition) de Nathalie Bourdaud et Frédéric Duflo aux éditions ARNETTE"),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ))));
  }
}
