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
  Map<String, String>? constantesPhysiologiques;

  bool isAgeInMonths = false; // Pour vérifier si l'âge est en mois ou en années
  double? dosePropofolmini;
  double? dosePropofolmaxi;
  double? doseEtomidate;
  double? doseKetaminemini;
  double? doseKetaminemaxi;
  double? doseSufentamini;
  double? doseSufentamaxi;
  double? doseAlfentanylmini;
  double? doseAlfentanylmaxi;
  double? doseRemifentanylmini;
  double? doseRemifentanylmaxi;
  double? doseFentanylmini;
  double? doseFentanylmaxi;
  double? doseCisatracrium;
  double? doseCelocurinemini;
  double? doseCelocurinemaxi;
  double? doseAtracrium;
  double? doseRocuroniummini;
  double? doseRocuroniummaxi;
  double? tailleSonde;
  double? apportLiquidien;
  double? vtmin;
  double? vtmax;

  double roundToHalf(double value) {
    return (value * 2).floor() / 2.0;
  }

  double calculerApportLiquidien(double poids) {
    double apport = 0;

    if (poids <= 10) {
      apport = poids * 4;
    } else if (poids <= 20) {
      apport = 10 * 4 + (poids - 10) * 2;
    } else {
      apport = 10 * 4 + 10 * 2 + (poids - 20) * 1;
    }

    return apport;
  }

  Map<String, String> obtenirConstantesPhysiologiques(int ageEnMois) {
    if (ageEnMois <= 5) {
      return {
        'FC': '140 (+/-50)',
        'PA': '60-35',
        'FR': '30-50',
      };
    } else if (ageEnMois <= 11) {
      return {
        'FC': '120 (+/-40)',
        'PA': '80-46',
        'FR': '26-30',
      };
    } else if (ageEnMois <= 35) {
      return {
        'FC': '110 (+/-40)',
        'PA': '96-65',
        'FR': '22-26',
      };
    } else if (ageEnMois <= 59) {
      return {
        'FC': '105 (+/-35)',
        'PA': '100-60',
        'FR': '20-24',
      };
    } else if (ageEnMois <= 95) {
      return {
        'FC': '105 (+/-35)',
        'PA': '100-60',
        'FR': '18-22',
      };
    } else if (ageEnMois <= 143) {
      return {
        'FC': '95 (+/-30)',
        'PA': '110-60',
        'FR': '16-20',
      };
    } else {
      return {
        'FC': '95 (+/-30)',
        'PA': '118-60',
        'FR': '14-18',
      };
    }
  }

  void calculerDosesEtSonde() {
    final int age = int.tryParse(ageController.text) ?? 0;
    final int ageEnMois = isAgeInMonths ? age : age * 12;
    final double poids = double.tryParse(poidsController.text) ?? 0.0;

    setState(() {
      dosePropofolmini = poids * 3.0; // Dose de propofol à 3 mg/kg
      dosePropofolmaxi = poids * 5.0; // Dose de propofol à 5 mg/kg
      doseEtomidate = poids * 0.2; // Dose de etomidate à 0.2 mg/kg
      doseKetaminemini = poids * 2.0;
      doseKetaminemaxi = poids * 4.0;
      doseSufentamini = poids * 0.2;
      doseSufentamaxi = poids * 0.4;
      doseAlfentanylmini = poids * 20.0;
      doseAlfentanylmaxi = poids * 40.0;
      doseRemifentanylmini = poids * 0.2;
      doseRemifentanylmaxi = poids * 0.5;
      doseFentanylmini = poids * 20.0;
      doseFentanylmaxi = poids * 50.0;
      doseCisatracrium = poids * 0.2;
      doseCelocurinemini = poids;
      doseCelocurinemaxi = poids * 2.0;
      doseAtracrium = poids * 0.5;
      doseRocuroniummini = poids * 0.6;
      doseRocuroniummaxi = poids * 1.2;
      apportLiquidien = calculerApportLiquidien(poids);
      constantesPhysiologiques = obtenirConstantesPhysiologiques(ageEnMois);
      vtmin = poids * 6.0;
      vtmax = poids * 8.0;

      if (ageEnMois < 12) {
        tailleSonde = roundToHalf(ageEnMois / 10.0 + 3.0);
      } else {
        tailleSonde = roundToHalf((ageEnMois / 12.0 + 16) / 4.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculette de Posologie'),
      ),
      body: SingleChildScrollView(
          child: Padding(
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
                      const Text('Changez entre année et mois'),
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

            //parametre vitaux
            if (constantesPhysiologiques == null) ...[
              Container(
                padding: const EdgeInsets.all(20),
                height: 250,
                width: 325,
                color: const Color.fromARGB(255, 0, 0, 0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fréquence Cardiaque: ',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      'Pression Artérielle: ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 248, 42, 42),
                          fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      'Fréquence Respiratoire: ',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text("Volume courant en ml",
                        style: TextStyle(
                          color: Color.fromARGB(255, 209, 219, 62),
                        ))

                    // calcul vt
                  ],
                ),
              )
            ],
            if (constantesPhysiologiques != null) ...[
              Container(
                padding: const EdgeInsets.all(20),
                height: 250,
                width: 325,
                color: const Color.fromARGB(255, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fréquence Cardiaque: ${constantesPhysiologiques!['FC']}',
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(
                      'Pression Artérielle: ${constantesPhysiologiques!['PA']}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 248, 42, 42),
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(
                      'Fréquence Respiratoire: ${constantesPhysiologiques!['FR']}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text("Volume courant $vtmin a $vtmax ml",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 209, 219, 62),
                        ))

                    // calcul vt
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16.0),

            //ventilation card
            Card(
              color: const Color.fromARGB(232, 165, 174, 184),
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iot("ML", "1", "divers"),
                  iot("IOT", "$tailleSonde", "divers"),
                  iot("Canule Guedel", "taille", "Couleur"),
                  iot("Hydratation", "$apportLiquidien", "ml/h")
                ],
              ),
            ),

            //medicaments card
            Card(
              color: const Color.fromARGB(193, 254, 255, 250),
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (constantesPhysiologiques == null) ...[
                    const Text(
                      "Entrez les parametres de l'enfant pour calculer les doses",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                  if (constantesPhysiologiques != null) ...[
                    hypnotiques(
                        "Propofol", "$dosePropofolmini", "$dosePropofolmaxi"),
                    const SizedBox(
                      height: 5,
                    ),
                    hypnotiques("Etomidate", "$doseEtomidate", " "),
                    const SizedBox(
                      height: 5,
                    ),
                    hypnotiques(
                        "Ketamine", "$doseKetaminemini", "$doseKetaminemaxi"),
                    const SizedBox(
                      height: 5,
                    ),
                    morphiniques("Sufenta", "$doseSufentamini",
                        "$doseSufentamaxi", "mcg"),
                    const SizedBox(
                      height: 5,
                    ),
                    morphiniques("Alfentanyl", "$doseAlfentanylmini",
                        "$doseAlfentanylmaxi", "mcg"),
                    const SizedBox(
                      height: 5,
                    ),
                    morphiniques("Remifentanil", "$doseRemifentanylmini",
                        "$doseRemifentanylmaxi", "mcg"),
                    const SizedBox(
                      height: 5,
                    ),
                    morphiniques("Fentanyl", "$doseFentanylmini",
                        "$doseFentanylmaxi", "mcg"),
                    const SizedBox(
                      height: 5,
                    ),
                    curares("Cisatracrium", "$doseCisatracrium", " "),
                    const SizedBox(
                      height: 5,
                    ),
                    curares("Célocurine", "$doseCelocurinemini",
                        "$doseCelocurinemaxi"),
                    const SizedBox(
                      height: 5,
                    ),
                    curares("Atracrium", "$doseAtracrium", " "),
                    const SizedBox(
                      height: 5,
                    ),
                    curares("Rocuronium", "$doseRocuroniummini",
                        "$doseRocuroniummaxi"),
                    const SizedBox(
                      height: 5,
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    poidsController.dispose();
    super.dispose();
  }
}

// iot/ ml / remplissage
Column iot(String ml, String taille, String divers) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(shape: BoxShape.rectangle),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ml,
              style: const TextStyle(
                  backgroundColor: Colors.blueGrey, color: Colors.red),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(taille),
            Text(divers),
          ],
        ),
      ),
      const SizedBox()
    ],
  );
}

Row hypnotiques(
  String medicament,
  String dosemini,
  String dosemaxi,
) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    //mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        padding: const EdgeInsets.all(5),
        height: 30,
        color: Colors.yellow,
        width: 150,
        child: Text(medicament,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500)),
      ),
      const Spacer(),
      Text(dosemini),
      const Text("  - "),
      Text(dosemaxi),
      const SizedBox(
        width: 5,
      ),
      const Text("mg"),
      const Spacer(),
    ],
  );
}

Row morphiniques(
    String medicament, String dosemini, String dosemaxi, String unite) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    //mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        padding: const EdgeInsets.all(5),
        height: 30,
        color: const Color.fromARGB(193, 92, 142, 233),
        width: 150,
        child: Text(medicament,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500)),
      ),
      const Spacer(),
      Text(dosemini),
      const Text("  - "),
      Text(dosemaxi),
      const SizedBox(
        width: 5,
      ),
      Text(unite),
      const Spacer(),
    ],
  );
}

Row curares(String medicament, String dosemini, String dosemaxi) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    //mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        padding: const EdgeInsets.all(5),
        height: 30,
        color: const Color.fromARGB(193, 233, 100, 91),
        width: 150,
        child: Text(medicament,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500)),
      ),
      const Spacer(),
      Text(dosemini),
      const Text("  - "),
      Text(dosemaxi),
      const SizedBox(
        width: 5,
      ),
      const Text("mg"),
      const Spacer(),
    ],
  );
}
