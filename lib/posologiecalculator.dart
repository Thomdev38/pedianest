// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'entretien.dart';

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
  Map<String, String>? circuit;
  Map<String, String>? ballon;
  Map<String, String>? tailleguedel;
  Map<String, String>? taillesonde;
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
  double? doseAdrenaline;
  double? doseAtropine;
  

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
    if (ageEnMois <= 1) {
      return {
        'FC': '90 - 180',
        'PAS': '60-80',
        'PAM': '> 40',
        'FR': '40 - 60',
      };
    } else if (ageEnMois <= 6) {
      return {
        'FC': '80 - 180',
        'PAS': '65 - 90',
        'PAM': '> 45',
        'FR': '30 - 40',
      };
    } else if (ageEnMois <= 24) {
      return {
        'FC': '60 - 160',
        'PAS': '70 - 94',
        'PAM': '> 50',
        'FR': '25 - 35',
      };
    } else if (ageEnMois <= 60) {
      return {
        'FC': '60 - 140',
        'PAS': '72 - 100',
        'PAM': '> 60',
        'FR': '25 - 30',
      };
    } else if (ageEnMois <= 120) {
      return {
        'FC': '60 - 130',
        'PAS': '80 - 110',
        'PAM': '> 60',
        'FR': '20 - 25',
      };
    } else {
      return {
        'FC': '60 - 130',
        'PAS': '90 - 120',
        'PAM': '> 65',
        'FR': '12 - 20',
      };
    }
  }
   Map<String, String> obtenirCircuit(int poids) {
    if (poids <= 5) {
      return {
        'circuit': 'Néonat',
      };
    } else if (poids <= 25) {
      return {
        'circuit': 'pédiatrique',
      };
    } else {
      return {
        'circuit': 'adulte',
      };
    }
  }

  Map<String, String> obtenirBallon(int poids) {
    if (poids <= 10) {
      return {
        'ballon': '0,5 litre',
      };
    } else if (poids <= 20) {
      return {
        'ballon': '1 litre',
      };
    } else if (poids <= 30) {
      return {
        'ballon': '2 litres',
      };
    } else {
      return {
        'ballon': 'adulte',
      };
    }
  }

  Map<String, String> obtenirtaillesonde(int poids) {
    if (poids <= 4) {
      return {
        'taillesonde': '3.0',
      };
    } else if (poids <= 9) {
      return {
        'taillesonde': '3.5',
      };
    } else if (poids <= 14) {
      return {
        'taillesonde': '4.0',
      };
    } else if (poids <= 19) {
      return {
        'taillesonde': '4.5',
      };
    } else if (poids <= 24) {
      return {
        'taillesonde': '5.0',
      };
    } else if (poids <= 29) {
      return {
        'taillesonde': '5.5',
      };
    } else if (poids <= 34) {
      return {
        'taillesonde': '6.0',
      };
    } else if (poids <= 39) {
      return {
        'taillesonde': '6.5',
      };
    } else {
      return {
        'ballon': '7.0',
      };
    }
  }



  Map<String, String> obtenirTailleLame(int poids) {
    if (poids <= 5) {
      return {
        'taillelame': '0 - 1',
      };
    } else if (poids <= 10) {
      return {
        'taillelame': '1',
      };
    } else if (poids <= 12) {
      return {
        'taillelame': '1 - 2',
      };
    } else if (poids <= 34) {
      return {
        'taillelame': '2',
      };
    } else {
      return {
        'taillelame': '3',
      };
    }
  }
  
  Map<String, String> obtenirTailleguedel(int ageEnMois) {
    if (ageEnMois <= 1) {
      return {
        'tailleguedel': '000 ou 00 (transparente / bleue )',
      };
    } else if (ageEnMois <= 12) {
      return {
        'tailleguedel': '0 (grise)',
      };
    } else if (ageEnMois <= 60) {
      return {
        'tailleguedel': '1 blanche',
      };
    } else if (ageEnMois <= 144) {
      return {
        'tailleguedel': '2 (verte)',
      };
    } else {
      return {
        'tailleguedel': '2 ou 3 (verte / orange)',
      };
    }
  }

  void calculerDosesEtSonde() {
    final int age = int.tryParse(ageController.text) ?? 0;
    final int ageEnMois = isAgeInMonths ? age : age * 12;
    final int poids = int.tryParse(poidsController.text) ?? 0;

    setState(() {
      dosePropofolmini = poids * 2; // Dose de propofol à 3 mg/kg
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
      doseProfenid = poids;
      doseMorphine = poids * 0.1;
      doseNalbuphine = poids * 0.2;
      dosePropofolEntretien = poids * 10.0; // 10 mg/kg/h;
      doseAdrenaline = poids * 0.01;
      doseAtropine = poids * 0.02;
      

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
      circuit = obtenirCircuit(poids);
      ballon = obtenirBallon(poids);
      taillesonde = obtenirtaillesonde(poids);
      tailleguedel = obtenirTailleguedel(ageEnMois);

      
      
     



     //if (ageEnMois < 12) {
       // tailleSonde = roundToHalf(ageEnMois / 10.0 + 3.0);
      //} else {
        //tailleSonde = roundToHalf((ageEnMois / 12.0 + 16) / 4.0);
      //}
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
              doseParacetamol: doseParacetamol,
              doseNalbuphine: doseNalbuphine,
              doseMorphine: doseMorphine,
              doseProfenid: doseProfenid,
              apportLiquidien: apportLiquidien,
              vtmin: vtmin,
              vtmax: vtmax,
              repereiot: repereiot,
              taillelame: taillelame,
              circuit: circuit,
              ballon: ballon,
              doseAdrenaline: doseAdrenaline,
              doseAtropine: doseAtropine, 
              taillesonde: taillesonde,
              tailleguedel: tailleguedel,
              
              
              
            ),
            EntretienPage(
              dosePropofolEntretien:
                  dosePropofolEntretien, // Passer la nouvelle variable
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
  final int? apportLiquidien;
  final int? vtmin;
  final int? doseParacetamol;
  final double? doseMorphine;
  final int? doseProfenid;
  final double? doseNalbuphine;
  final double? doseAdrenaline;
  final double? doseAtropine;
  final int? vtmax;
  final double? repereiot;
  final Map<String, String>? taillelame;
  final Map<String, String>? circuit;
  final Map<String, String>? ballon;
  final Map<String, String>? taillesonde;
  final Map<String, String>? tailleguedel;

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
    required this.apportLiquidien,
    required this.vtmin,
    required this.vtmax,
    required this.repereiot,
    required this.taillelame,
    required this.doseParacetamol,
    required this.doseProfenid,
    required this.doseMorphine,
    required this.doseNalbuphine,
    required this.doseAdrenaline,
    required this.doseAtropine,
    required this.circuit,
    required this.ballon,
    required this.taillesonde,
    required this.tailleguedel,
    
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
          const SizedBox(height: 12),
          TextField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Âge',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 2),
          SwitchListTile(
            title: const Text('Âge en mois'),
            value: isAgeInMonths,
            onChanged: onSwitchChanged,
            activeColor: Colors.green.shade400,
          ),
          const SizedBox(height: 2),
          TextField(
            controller: poidsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Poids (kg)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 1),
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
            Text('PAS: ${constantesPhysiologiques!['PAS']}'),
            Text('PAM: ${constantesPhysiologiques!['PAM']}'),
            Text('FR: ${constantesPhysiologiques!['FR']}'),
            const SizedBox(height: 16),
          ],
          if (taillesonde != null) ...[
            const Text(
              "Ventilation",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Circuit: ${circuit!['circuit']}',style: const TextStyle(fontSize: 16),),
            Text('Ballon: ${ballon!['ballon']}',style: const TextStyle(fontSize: 16),),
            Text(
              'Taille Sonde IOT: ${taillesonde!['taillesonde']}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
          if (taillelame != null) ...[
            const SizedBox(height: 4),
            Text(
              'Taille Lame: ${taillelame!['taillelame']}',
              style: const TextStyle(fontSize: 16),
            ),
          
            const SizedBox(height: 4),
            Text(
              'Taille Guedel: ${tailleguedel!['tailleguedel']}',
              style: const TextStyle(fontSize: 16),
            ),
          
          ],
          if (repereiot != null) ...[
            const SizedBox(height: 4),
            Text('Repère IOT: ${repereiot!.toStringAsFixed(0)} cm',
                style: const TextStyle(fontSize: 16)),
          ],
          if (vtmin != null && vtmax != null) ...[
            const SizedBox(height: 4),
            Text(
              'Volume courant: $vtmin - $vtmax ml',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
          ],
          if (apportLiquidien != null) ...[
            const Text(
              "Divers",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Apport Liquidien de base: $apportLiquidien ml/h (au PSE chez le- de 10kg sinon avec régulateur de débit)' ,
              style: const TextStyle(fontSize: 16),
            ),
            const Text("Compensation du jeune: Durée du jeune x besoin horaire = volume à compenser", style: TextStyle(fontSize: 11),),
            const Text("Passer 50% de ce volume la première heure et 50% sur la deuxième heure", style: TextStyle(fontSize: 11),),
          ],
          const SizedBox(height: 16),
          if (dosePropofolmini != null && dosePropofolmaxi != null) ...[
            //container des médicaments (en noir)
            Container(
              padding: const EdgeInsets.all(2),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black54)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Doses Induction',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  //container des hypnotiques
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.yellow,
                        width: 5,
                      ),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          "Hypnotiques:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Propofol: $dosePropofolmini - $dosePropofolmaxi mg',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Etomidate: ${doseEtomidate!.toStringAsFixed(1)} mg',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Ketamine (en dose d'induction): $doseKetaminemini - $doseKetaminemaxi mg",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                  //container bleu des morphiniques
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade700, width: 5),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Morphiniques:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Sufentanyl: ${doseSufentamini!.toStringAsFixed(1)} - ${doseSufentamaxi!.toStringAsFixed(1)} µg',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Alfentanyl: $doseAlfentanylmini - $doseAlfentanylmaxi µg',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Remifentanyl: ${doseRemifentanylmini!.toStringAsFixed(1)} - ${doseRemifentanylmaxi!.toStringAsFixed(1)} µg',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Fentanyl: $doseFentanylmini - $doseFentanylmaxi µg',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  //container rouge des curares
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade700, width: 5),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                    "Curares:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Cisatracrium: ${doseCisatracrium!.toStringAsFixed(1)} mg',
                    style: const TextStyle(
                        fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Celocurine: $doseCelocurinemini mg',
                    style: const TextStyle(
                        fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Atracrium: ${doseAtracrium!.toStringAsFixed(1)} mg',
                    style: const TextStyle(
                        fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Rocuronium: ${doseRocuroniummini!.toStringAsFixed(0)} - ${doseRocuroniummaxi!.toStringAsFixed(0)} mg',
                    style: const TextStyle(
                         fontSize: 16),
                  ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                   //container rouge des antalgiques
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple.shade400, width: 5),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                  const Text(
                    "Amines:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Adrénaline: ${doseAdrenaline!.toStringAsFixed(2)}  mg',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Atropine: ${doseMorphine!.toStringAsFixed(2)}  mg',
                    style: const TextStyle(fontSize: 16),
                  ),
                  RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Noradrénaline: ',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Noradre 3mg(1,5ml) + Séreum phy 48,5ml soit 0,06mg/ml => 0.1-0.3g/kg/min = O.1-0.3ml/kg/h',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                   //container violet des amines
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green.shade400, width: 5),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                    "Antalgiques:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Paracétamol: ${doseParacetamol!.toStringAsFixed(0)} mg',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Profénid: $doseProfenid mg',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Nalbuphine: ${doseNalbuphine!.toStringAsFixed(1)} mg',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Morphine: ${doseMorphine!.toStringAsFixed(1)}  mg',
                    style: const TextStyle(fontSize: 16),
                  ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                    
                  const SizedBox(height: 16),
                  const Text(
                    "Autres:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("data"),
                ],
              ),
            )
          ],
        ],
      ),
    );
  }
}
