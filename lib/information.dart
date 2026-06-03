import 'package:flutter/material.dart';
import 'package:pedianesth/responsive.dart';

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
            child: ResponsiveCenter(
          maxWidth: 700,
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
                radius: (MediaQuery.of(context).size.width * 0.3)
                    .clamp(80.0, 150.0),
                child: Image.asset("assets/images/ours.jpg"),
              )
            ],
          ),
        )));
  }
}
