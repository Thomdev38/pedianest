// ignore_for_file: must_be_immutable

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
  Map<String, String>? taillelame;

  bool isAgeInMonths = false; // Pour vérifier si l'âge est en mois ou en années
  int? dosePropofolmini;
  int? dosePropofolmaxi;
  double? doseEtomidate;
  int? doseKetaminemini;
  int? doseKetaminemaxi;
  double? doseSufentamini;
  double? doseSufentamaxi;
  int? doseAlfentanylmini;
  int? doseAlfentanylmaxi;
  double? doseRemifentanylmini;
  double? doseRemifentanylmaxi;
  int? doseFentanylmini;
  int? doseFentanylmaxi;
  double? doseCisatracrium;
  int? doseCelocurinemini;
  int? doseCelocurinemaxi;
  double? doseAtracrium;
  double? doseRocuroniummini;
  double? doseRocuroniummaxi;
  double? tailleSonde;
  int? apportLiquidien;
  int? vtmin;
  int? vtmax;
  double? repereiot;
  int? celo;
  int? doseParacetamol;
  int? doseProfenid;
  double? doseNalbuphine;
  double? doseMorphine;
  double? dosePropofolEntretien;

  double roundToHalf(double value) {
    return (value * 2).floor() / 2.0;
  }

  int calculerApportLiquidien(int poids) {
    int apport = 0;

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
    if (ageEnMois <= 6) {
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
    } else {
      return {
        'FC': '95 (+/-30)',
        'PA': '118-60',
        'FR': '14-18',
      };
    }
  }

  Map<String, String> obtenirTailleLame(int poids) {
    if (poids <= 5) {
      return {
        'taillelame': '0 - 1',
      };
    } else if (poids <= 11) {
      return {
        'taillelame': '1',
      };
    } else if (poids <= 35) {
      return {
        'taillelame': '2',
      };
    } else {
      return {
        'taillelame': '3',
      };
    }
  }

  void calculerDosesEtSonde() {
    final int age = int.tryParse(ageController.text) ?? 0;
    final int ageEnMois = isAgeInMonths ? age : age * 12;
    final int poids = int.tryParse(poidsController.text) ?? 0;

    setState(() {
      dosePropofolmini = poids * 3; // Dose de propofol à 3 mg/kg
      dosePropofolmaxi = poids * 5; // Dose de propofol à 5 mg/kg
      doseEtomidate = poids * 0.2; // Dose de etomidate à 0.2 mg/kg
      doseKetaminemini = poids * 2;
      doseKetaminemaxi = poids * 4;
      doseSufentamini = poids * 0.2;
      doseSufentamaxi = poids * 0.4;
      doseAlfentanylmini = poids * 20;
      doseAlfentanylmaxi = poids * 40;
      doseRemifentanylmini = poids * 0.2;
      doseRemifentanylmaxi = poids * 0.5;
      doseFentanylmini = poids * 20;
      doseFentanylmaxi = poids * 50;
      doseCisatracrium = poids * 0.2;
      doseParacetamol = poids * 15;
      doseProfenid = poids ;
      doseMorphine = poids * 0.1;
      doseNalbuphine = poids * 0.2;
      dosePropofolEntretien = poids * 10.0; // 10 mg/kg/h

      // Condition spécifique pour la dose de célocurine
      if (ageEnMois < 24) {
        doseCelocurinemini = poids * 2;
      } else {
        doseCelocurinemini = poids;
      }

      doseAtracrium = poids * 0.5;
      doseRocuroniummini = poids * 0.6;
      doseRocuroniummaxi = poids * 1.2;
      apportLiquidien = calculerApportLiquidien(poids);
      constantesPhysiologiques = obtenirConstantesPhysiologiques(ageEnMois);
      vtmin = poids * 6;
      vtmax = poids * 8;
      repereiot = ageEnMois / 12 / 2 + 12;
      taillelame = obtenirTailleLame(poids);

      if (ageEnMois < 12) {
        tailleSonde = roundToHalf(ageEnMois / 10.0 + 3.0);
      } else {
        tailleSonde = roundToHalf((ageEnMois / 12.0 + 16) / 4.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculette de Posologie'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Induction'),
              Tab(text: 'Entretien'),
              
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InductionPage(
              ageController: ageController,
              poidsController: poidsController,
              isAgeInMonths: isAgeInMonths,
              onSwitchChanged: (value) {
                setState(() {
                  isAgeInMonths = value;
                });
              },
              onCalculate: calculerDosesEtSonde,
              constantesPhysiologiques: constantesPhysiologiques,
              dosePropofolmini: dosePropofolmini,
              dosePropofolmaxi: dosePropofolmaxi,
              doseEtomidate: doseEtomidate,
              doseKetaminemini: doseKetaminemini,
              doseKetaminemaxi: doseKetaminemaxi,
              doseSufentamini: doseSufentamini,
              doseSufentamaxi: doseSufentamaxi,
              doseAlfentanylmini: doseAlfentanylmini,
              doseAlfentanylmaxi: doseAlfentanylmaxi,
              doseRemifentanylmini: doseRemifentanylmini,
              doseRemifentanylmaxi: doseRemifentanylmaxi,
              doseFentanylmini: doseFentanylmini,
              doseFentanylmaxi: doseFentanylmaxi,
              doseCisatracrium: doseCisatracrium,
              doseCelocurinemini: doseCelocurinemini,
              doseCelocurinemaxi: doseCelocurinemaxi,
              doseAtracrium: doseAtracrium,
              doseRocuroniummini: doseRocuroniummini,
              doseRocuroniummaxi: doseRocuroniummaxi,
              tailleSonde: tailleSonde,
              doseParacetamol: doseParacetamol,
              doseNalbuphine: doseNalbuphine,
              doseMorphine: doseMorphine,
              doseProfenid: doseProfenid,
              apportLiquidien: apportLiquidien,
              vtmin: vtmin,
              vtmax: vtmax,
              repereiot: repereiot,
              taillelame: taillelame,
            ),
            EntretienPage(
              dosePropofolEntretien: dosePropofolEntretien, // Passer la nouvelle variable
            ),
            
          ],
        ),
      ),
    );
  }
}

class InductionPage extends StatelessWidget {
  final TextEditingController ageController;
  final TextEditingController poidsController;
  final bool isAgeInMonths;
  final Function(bool) onSwitchChanged;
  final VoidCallback onCalculate;
  final Map<String, String>? constantesPhysiologiques;
  final int? dosePropofolmini;
  final int? dosePropofolmaxi;
  final double? doseEtomidate;
  final int? doseKetaminemini;
  final int? doseKetaminemaxi;
  final double? doseSufentamini;
  final double? doseSufentamaxi;
  final int? doseAlfentanylmini;
  final int? doseAlfentanylmaxi;
  final double? doseRemifentanylmini;
  final double? doseRemifentanylmaxi;
  final int? doseFentanylmini;
  final int? doseFentanylmaxi;
  final double? doseCisatracrium;
  final int? doseCelocurinemini;
  final int? doseCelocurinemaxi;
  final double? doseAtracrium;
  final double? doseRocuroniummini;
  final double? doseRocuroniummaxi;
  final double? tailleSonde;
  final int? apportLiquidien;
  final int? vtmin;
  final int? doseParacetamol;
  final double? doseMorphine;
  final int? doseProfenid;
  final double? doseNalbuphine;

  final int? vtmax;
  final double? repereiot;
  final Map<String, String>? taillelame;
  int? dosePropofolEntretien;

 

  InductionPage({
    super.key,
    required this.ageController,
    required this.poidsController,
    required this.isAgeInMonths,
    required this.onSwitchChanged,
    required this.onCalculate,
    required this.constantesPhysiologiques,
    required this.dosePropofolmini,
    required this.dosePropofolmaxi,
    required this.doseEtomidate,
    required this.doseKetaminemini,
    required this.doseKetaminemaxi,
    required this.doseSufentamini,
    required this.doseSufentamaxi,
    required this.doseAlfentanylmini,
    required this.doseAlfentanylmaxi,
    required this.doseRemifentanylmini,
    required this.doseRemifentanylmaxi,
    required this.doseFentanylmini,
    required this.doseFentanylmaxi,
    required this.doseCisatracrium,
    required this.doseCelocurinemini,
    required this.doseCelocurinemaxi,
    required this.doseAtracrium,
    required this.doseRocuroniummini,
    required this.doseRocuroniummaxi,
    required this.tailleSonde,
    required this.apportLiquidien,
    required this.vtmin,
    required this.vtmax,
    required this.repereiot,
    required this.taillelame,
    required this.doseParacetamol,
    required this.doseProfenid,
    required this.doseMorphine,
    required this.doseNalbuphine,

  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Induction',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Âge',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Âge en mois'),
            value: isAgeInMonths,
            onChanged: onSwitchChanged,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: poidsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Poids (kg)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onCalculate,
            child: const Text('Calculer'),
          ),
          const SizedBox(height: 16),
          if (constantesPhysiologiques != null) ...[
            const Text(
              'Constantes Physiologiques',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('FC: ${constantesPhysiologiques!['FC']}'),
            Text('PA: ${constantesPhysiologiques!['PA']}'),
            Text('FR: ${constantesPhysiologiques!['FR']}'),
            const SizedBox(height: 16),
          ],

          const Text("Matériel de ventilation", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

          if (tailleSonde != null) ...[
            const Text(
              'Taille de la Sonde',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Taille de la sonde: $tailleSonde'),
            const SizedBox(height: 16),
          ],
           if (taillelame != null) ...[
            const Text(
              'Taille Lame',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Taille Lame: ${taillelame!['taillelame']}'),
            const SizedBox(height: 16),
          ],
          if (repereiot != null) ...[
            const Text(
              'Repère IOT',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Repère IOT: ${repereiot!.toStringAsFixed(0)} cm'),
            const SizedBox(height: 16),
          ],
          if (apportLiquidien != null) ...[
            const Text(
              'Apport Liquidien',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Apport Liquidien: $apportLiquidien ml/h'),
            const SizedBox(height: 16),
          ],
          if (vtmin != null && vtmax != null) ...[
            const Text(
              'Volume Courant',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text('Volume courant: $vtmin - $vtmax ml'),
            const SizedBox(height: 16),
          ],
          
         


          if (dosePropofolmini != null && dosePropofolmaxi != null) ...[
            const Text(
              'Doses Induction',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Hypnotiques:",style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold,),),
            Text('Propofol: $dosePropofolmini - $dosePropofolmaxi mg', style: const TextStyle(backgroundColor: Colors.yellow,fontSize: 16),),
            const SizedBox(height: 2),
            Text('Etomidate: ${doseEtomidate!.toStringAsFixed(1)} mg', style: const TextStyle(backgroundColor: Colors.yellow,fontSize: 16),),
            const SizedBox(height: 2),
            Text('Ketamine: $doseKetaminemini - $doseKetaminemaxi mg', style: const TextStyle(backgroundColor: Colors.yellow, fontSize: 16),),
            
            const SizedBox(height: 8),
            const Text("Morphiniques:",style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold,),),
            Text('Sufentanyl: ${doseSufentamini!.toStringAsFixed(1)} - ${doseSufentamaxi!.toStringAsFixed(1)} µg', style: const TextStyle(backgroundColor: Colors.blue, fontSize: 16),),
            const SizedBox(height: 2),
            Text('Alfentanyl: $doseAlfentanylmini - $doseAlfentanylmaxi µg', style: const TextStyle(backgroundColor: Colors.blue, fontSize: 16),),
            const SizedBox(height: 2),
            Text('Remifentanyl: ${doseRemifentanylmini!.toStringAsFixed(1)} - ${doseRemifentanylmaxi!.toStringAsFixed(1)} µg', style: const TextStyle(backgroundColor: Colors.blue, fontSize: 16),),
            const SizedBox(height: 2),
            Text('Fentanyl: $doseFentanylmini - $doseFentanylmaxi µg', style: const TextStyle(backgroundColor: Colors.blue, fontSize: 16),),
            const SizedBox(height: 8),
            const Text("Curares:",style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold,),),
            Text('Cisatracrium: ${doseCisatracrium!.toStringAsFixed(1)} mg', style: const TextStyle(backgroundColor: Colors.red, fontSize: 16),),
            const SizedBox(height: 2),
            Text('Celocurine: $doseCelocurinemini mg', style: const TextStyle(backgroundColor: Colors.red, fontSize: 16),),
            const SizedBox(height: 2),
            Text('Atracrium: ${doseAtracrium!.toStringAsFixed(1)} mg', style: const TextStyle(backgroundColor: Colors.red, fontSize: 16),),
            const SizedBox(height: 2),
            Text('Rocuronium: ${doseRocuroniummini!.toStringAsFixed(0)} - ${doseRocuroniummaxi!.toStringAsFixed(0)} mg', style: const TextStyle(backgroundColor: Colors.red, fontSize: 16),),
            const SizedBox(height: 16),
            const SizedBox(height: 8),
            const Text("Antalgiques:",style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold,),),
            Text('Paracétamol: ${doseParacetamol!.toStringAsFixed(0)} mg', style: const TextStyle( fontSize: 16),),
            const SizedBox(height: 2),
            Text('Profénid: $doseProfenid mg', style: const TextStyle( fontSize: 16),),
            const SizedBox(height: 2),
            Text('Nalbuphine: ${doseNalbuphine!.toStringAsFixed(1)} mg', style: const TextStyle( fontSize: 16),),
            const SizedBox(height: 2),
            Text('Morphine: ${doseMorphine!.toStringAsFixed(1)}  mg', style: const TextStyle( fontSize: 16),),
            const SizedBox(height: 16),
          ],
          
        ],
      ),
    );
  }
}



class EntretienPage extends StatelessWidget {
  final double? dosePropofolEntretien; // Recevoir la variable du parent

  const EntretienPage({super.key, this.dosePropofolEntretien});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Entretien Page',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (dosePropofolEntretien != null)
            Text(
              'Dose d\'entretien de Propofol: ${dosePropofolEntretien!.toStringAsFixed(1)} mg/kg/h',
              style: const TextStyle(fontSize: 16),
            ),
          // Autres éléments à afficher...
        ],
      ),
    );
  }
}

