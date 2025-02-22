import 'package:flutter/material.dart';

class Sourcesen extends StatefulWidget {
  const Sourcesen({super.key});

  @override
  State<Sourcesen> createState() => _SourcesenState();
}

class _SourcesenState extends State<Sourcesen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sources"),
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
                        "Cette application d'aide au calcul de posologie s'est appuyé sur les sites, livres et applications suivantes:"),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Le Vidal: https://www.vidal.fr/"),
                    SizedBox(
                      height: 8,
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
                      height: 8,
                    ),
                    Text("https://pharmapp.care/"),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ))));
  }
}
