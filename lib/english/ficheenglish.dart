import 'package:flutter/material.dart';
import 'package:pedianesth/urgences/acrenfant.dart';
import 'package:pedianesth/urgences/anaphylaxienfant.dart';
import 'package:pedianesth/urgences/htmenfant.dart';
import 'package:pedianesth/urgences/intoxalenfant.dart';
import 'package:pedianesth/urgences/iotdiffenfant.dart';
import 'package:pedianesth/urgences/laryngospasme.dart';
import 'package:pedianesth/urgences/reanne.dart';

class Fiches extends StatefulWidget {
  const Fiches({super.key});

  @override
  State<Fiches> createState() => _FichesState();
}

class _FichesState extends State<Fiches> {
  final List<String> items = [
    "ACR",
    "Anaphylaxie",
    "Hyperthermie maligne",
    "Intoxication Anesthésique locaux",
    "Intubation difficile",
    "Laryngospasme",
    "Rea du nouveau née"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Fiches reflexe",
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Naviguer vers l'écran de détails en passant des données si nécessaire
                String selectedItem = items[index];
                Widget pageToNavigate;

                switch (selectedItem) {
                  case "ACR":
                    pageToNavigate = const Acrenfant();
                    break;
                  case "Anaphylaxie":
                    pageToNavigate = const Anaphylaxieenfant();
                    break;
                  case "Hyperthermie maligne":
                    pageToNavigate = const Htmenfant();
                    break;
                  case "Intoxication Anesthésique locaux":
                    pageToNavigate = const Intoxalenfant();
                    break;
                  case "Intubation difficile":
                    pageToNavigate = const Iotdiffenfant();
                    break;
                  case "Laryngospasme":
                    pageToNavigate = const Laryngospasme();
                    break;
                  case "Rea du nouveau née":
                    pageToNavigate = const Reanne();
                    break;

                  default:
                    pageToNavigate = const Acrenfant(); // Page par défaut
                }

                // Naviguer vers la page sélectionnée
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pageToNavigate),
                );
              },
              child: Card(
                margin: const EdgeInsets.only(left: 5, top: 5, right: 5),
                elevation: 10,
                color: const Color.fromRGBO(98, 190, 243, 0.498),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(
                    items[index],
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ));
  }
}
