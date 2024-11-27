import 'package:flutter/material.dart';

class PosologieCalculatorScreen extends StatefulWidget {
  const PosologieCalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PosologieCalculatorScreenState createState() =>
      _PosologieCalculatorScreenState();
}

class _PosologieCalculatorScreenState extends State<PosologieCalculatorScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController poidsController = TextEditingController();
  bool isAgeInMonths = false; // Pour vérifier si l'âge est en mois ou en années
  double? dosePropofol;
  double? doseCurare;
  double? tailleSonde;
  double? apportliquidien;

  double roundToHalf(double value) {
    return (value * 2).floor() / 2.0;
  }

  void calculerDosesEtSonde() {
    final int age = int.tryParse(ageController.text) ?? 0;
    final double poids = double.tryParse(poidsController.text) ?? 0.0;

    setState(() {
      dosePropofol = poids * 3.0; // Dose de propofol à 3 mg/kg
      doseCurare = poids * 2.0; // Dose de curare à 2 mg/kg
      apportliquidien = poids * 4;

      if (isAgeInMonths) {
        // Convertir l'âge en mois en années pour le calcul si nécessaire
        final double ageInYears = age / 12.0;
        if (ageInYears < 1) {
          tailleSonde = roundToHalf(age / 10.0 +
              3.0); // Taille de la sonde pour enfants de moins de 1 an
        } else {
          tailleSonde = roundToHalf((ageInYears + 16) /
              4.0); // Taille de la sonde pour enfants de 1 an et plus
        }
      } else {
        if (age < 1) {
          tailleSonde = roundToHalf(age / 10.0 +
              3.0); // Taille de la sonde pour enfants de moins de 1 an
        } else {
          tailleSonde = roundToHalf((age + 16) /
              4.0); // Taille de la sonde pour enfants de 1 an et plus
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculette de Posologie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ignore: avoid_unnecessary_containers
            Card(
              color: const Color.fromARGB(232, 149, 228, 179),
              elevation: 10,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Entrée en mois'),
                      Switch(
                        value: isAgeInMonths,
                        onChanged: (value) {
                          setState(() {
                            isAgeInMonths = value;
                          });
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: isAgeInMonths ? 'Âge (mois)' : 'Âge (années)',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: poidsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Poids (kg)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: calculerDosesEtSonde,
                    child: const Text('Calcul'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            Card(
              color: const Color.fromARGB(232, 165, 174, 184),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Column(
                    children: [
                      Column(
                        children: [
                          Text("ML"),
                          Text("Taille"),
                          Text("volume 7 ml"),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      if (tailleSonde != null) const Text('Taille '),
                      if (tailleSonde != null)
                        Text(
                          tailleSonde!.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      const Text("volume 7 ml"),
                    ],
                  ),
                  const Column(
                    children: [
                      Text("Guedel"),
                      Text("Taille"),
                      Text("volume 7 ml"),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Apport liquidien"),
                      if (apportliquidien != null)
                        Text(
                          apportliquidien!.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      const Text("ml/h"),
                    ],
                  ),
                ],
              ),
            ),
            if (dosePropofol != null)
              Text(
                'Dose de propofol: ${dosePropofol!.toStringAsFixed(2)} mg',
                style: const TextStyle(fontSize: 20.0),
              ),
            if (doseCurare != null)
              Text(
                'Dose de curare: ${doseCurare!.toStringAsFixed(2)} mg',
                style: const TextStyle(fontSize: 20.0),
              ),
            if (tailleSonde != null)
              Text(
                'Taille de la sonde d\'intubation: ${tailleSonde!.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 20.0),
              ),

            if (apportliquidien != null)
              Text(
                'Dose de curare: ${doseCurare!.toStringAsFixed(2)} mg',
                style: const TextStyle(fontSize: 20.0),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    poidsController.dispose();
    super.dispose();
  }
}
