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
                    "Cette application a été construite en fonction des différentes recommandations Française et internationale sur la prise en charge anesthésique des enfants. Le développeur de PEDIANESTH ne peut être tenu responsable des différents problèmes pouvant survenir sur vos patients. L'application n'est qu'une aide cognitive, si doute référé vous aux protocoles de vos établissements ou à vos collègues.   "),
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
