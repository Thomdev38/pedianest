import 'package:flutter/material.dart';

class Informationen extends StatefulWidget {
  const Informationen({super.key});

  @override
  State<Informationen> createState() => _InformationenState();
}

class _InformationenState extends State<Informationen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Décharge de responsabilité"),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Text(
                    "Cette application a été construite en fonction des différentes recommandations Française et internationale sur la prise en charge anesthésique des enfants. Le développeur de PEDIANESTH ne peut être tenu responsable des différents problèmes pouvant survenir sur vos patients suite à l'utilisation de cette application. L'application n'est qu'une aide cognitive, si doute référer vous aux protocoles de vos établissements, à vos collègues et allez voir les recommandations des sociétés savantes.   "),
                const SizedBox(
                  height: 80,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black12,
                  radius: 150,
                  child: Image.asset("assets/images/ours.jpg"),
                )
              ],
            )));
  }
}
