import 'package:flutter/material.dart';

import 'package:pedianesth/antibiotique.dart';
import 'package:pedianesth/entretien.dart';

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
  Map<String, String>? tailleaspi;
  Map<String, String>? hb;
  Map<String, String>? volumesanguin;

  bool isAgeInMonths = false; // Pour vérifier si l'âge est en mois ou en années
  int? dosePropofolmini;
  int? hypotensionsup1;
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
  int? poidstext;
  int? remplissagevasc;
  double? doseDexametasone;
  double? doseNarcan;
  double? doseketaNMDA;
  double? doseExacyl;
  int? doseLidocaine;
  int? dosePrilocaine;
  int? doseRopivacaine;
  double? doseBupivacaine;
  int? doseCefazoline;
  int? doseAmox;
  int? doseClindamycine;
  int? doseGentamycine;
  int? doseCefoxitine;
  int? doseMetronidazole;
  int? doseVancomycinemini;
  int? doseVancomycinemaxi;
  int? agemoistext;
  int? ageEnMois;
  double? doseOndansetron;
  int? doseminPFC;
  int? dosemaxPFC;
  int? doseminPqt;
  int? dosemaxPqt;

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
        'FC': '140 - 180',
        'PAS': '60-35',
        'FR': '30 - 60',
        'Hypotension': 'si PAM < âge gestationnel à la naissance (SA)',
      };
    } else if (ageEnMois <= 12) {
      return {
        'FC': '120 - 150',
        'PAS': '90 - 65',
        'FR': '24 - 40',
        'Hypotension': 'si PAM < âge gestationnel à la naissance (SA)',
      };
    } else if (ageEnMois <= 24) {
      return {
        'FC': '110 - 130',
        'PAS': '95 - 65',
        'FR': '20 - 30',
        'Hypotension': 'si PAS <$hypotensionsup1',
      };
    } else if (ageEnMois <= 60) {
      return {
        'FC': '105 - 120',
        'PAS': '110 - 60',
        'FR': '16 - 20',
        'Hypotension': 'si PAS <$hypotensionsup1',
      };
    } else {
      return {
        'FC': '70 - 100',
        'PAS': '120 - 65',
        'FR': '16 - 20',
        'Hypotension': 'si PAS <$hypotensionsup1',
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

  Map<String, String> obtenirtauxhb(int ageEnMois) {
    if (ageEnMois < 1) {
      return {
        'hb': '17 g/dl',
      };
    } else if (ageEnMois < 2) {
      return {
        'hb': '14 g/dl',
      };
    } else if (ageEnMois < 3) {
      return {
        'hb': '10 - 11 g/dl (anémie physiologique)',
      };
    } else if (ageEnMois < 24) {
      return {
        'hb': '12 g/dl',
      };
    } else if (ageEnMois < 72) {
      return {
        'hb': '13.5 g/dl',
      };
    } else {
      return {
        'hb': '14 g/dl',
      };
    }
  }

  Map<String, String> obtenirtaillesonde(int poids) {
    if (poids <= 4) {
      return {
        'taillesonde': '2.5 à 3.0',
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
        'taillesonde': '7.0',
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

  Map<String, String> obtenirTailleAspi(int poids) {
    if (poids < 5) {
      return {
        'tailleaspi': '6 - 8',
      };
    } else if (poids <= 10) {
      return {
        'tailleaspi': '8',
      };
    } else if (poids <= 15) {
      return {
        'tailleaspi': '10',
      };
    } else if (poids <= 20) {
      return {
        'tailleaspi': '12',
      };
    } else if (poids <= 35) {
      return {
        'tailleaspi': '14',
      };
    } else {
      return {
        'tailleaspi': '16',
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
    int ageEnMois = isAgeInMonths ? age : age * 12;
    final int poids = int.tryParse(poidsController.text) ?? 0;

    setState(() {
      hypotensionsup1 = age + 70;
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
      poidstext = poids * 1;
      agemoistext = ageEnMois * 1;
      remplissagevasc = poids * 20;
      doseDexametasone = poids * 0.15;
      doseNarcan = poids * 0.1;
      doseketaNMDA = poids * 0.2;
      doseExacyl = poids * 20;
      doseLidocaine = poids * 5;
      doseBupivacaine = poids * 2.5;
      dosePrilocaine = poids * 5;
      doseRopivacaine = poids * 3;
      doseCefazoline = poids * 30;
      doseAmox = poids * 50;
      doseClindamycine = poids * 10;
      doseGentamycine = poids * 6;
      doseCefoxitine = poids * 40;
      doseMetronidazole = poids * 15;
      doseVancomycinemini = poids * 20;
      doseVancomycinemaxi = poids * 30;
      doseminPFC = poids * 10;
      dosemaxPFC = poids * 30;
      doseminPqt = poids * 15;
      dosemaxPqt = poids * 20;
      doseOndansetron = poids * 0.1;

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
      tailleaspi = obtenirTailleAspi(poids);
      circuit = obtenirCircuit(poids);
      ballon = obtenirBallon(poids);
      taillesonde = obtenirtaillesonde(poids);
      tailleguedel = obtenirTailleguedel(ageEnMois);
      hb = obtenirtauxhb(ageEnMois);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculette de Posologie'),
          centerTitle: true,
          bottom: const TabBar(
            isScrollable: true,
            dividerColor: Colors.deepPurple,
            indicatorWeight: 4.0,
            indicatorColor: Color.fromARGB(255, 230, 129, 163),
            tabs: [
              Tab(text: 'Anesthésie'),
              Tab(text: 'Urgences'),
              Tab(
                text: "Antibiotiques/ ALR",
              ),
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
              tailleaspi: tailleaspi,
              tailleguedel: tailleguedel,
              remplissagevasc: remplissagevasc,
              doseDexametasone: doseDexametasone,
              doseNarcan: doseNarcan,
              doseketaNMDA: doseketaNMDA,
              doseOndansetron: doseOndansetron,
              hypotensionsup1: hypotensionsup1,
            ),
            UrgencePage(
              dosePropofolEntretien: dosePropofolEntretien,
              poidstext: poidstext,
              dosemaxPFC: dosemaxPFC,
              doseminPFC: doseminPFC,
              dosemaxPqt: dosemaxPqt,
              doseminPqt: doseminPqt,
              agemoistext: agemoistext,
              hb: hb,

              doseExacyl: doseExacyl, // Passer la nouvelle variable
            ),
            AntibioPage(
              dosePropofolEntretien: dosePropofolEntretien,
              poidstext: poidstext, // Passer la nouvelle variable
              doseLidocaine: doseLidocaine,
              doseBupivacaine: doseBupivacaine,

              dosePrilocaine: dosePrilocaine,
              doseRopivacaine: doseRopivacaine,
              doseClindamycine: doseClindamycine,
              doseGentamycine: doseGentamycine,
              doseCefoxitine: doseCefoxitine,
              doseMetronidazole: doseMetronidazole,
              doseVancomycinemini: doseVancomycinemini,
              doseVancomycinemaxi: doseVancomycinemaxi,
              doseAmox: doseAmox,
              doseCefazoline: doseCefazoline,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
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
  final int? remplissagevasc;
  final double? repereiot;
  final double? doseNarcan;
  final Map<String, String>? taillelame;
  final Map<String, String>? circuit;
  final Map<String, String>? ballon;
  final Map<String, String>? taillesonde;
  final Map<String, String>? tailleaspi;
  final Map<String, String>? tailleguedel;

  final int? hypotensionsup1;
  final double? doseDexametasone;
  final double? doseketaNMDA;
  final double? doseOndansetron;

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
    required this.tailleaspi,
    required this.remplissagevasc,
    required this.doseDexametasone,
    required this.doseNarcan,
    required this.doseketaNMDA,
    required this.doseOndansetron,
    required this.hypotensionsup1,
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
            keyboardType: TextInputType.text,
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
            keyboardType: TextInputType.text,
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
          const SizedBox(
            height: 40,
          ),
          if (constantesPhysiologiques == null) ...[
            Container(
              height: 100,
              width: double.infinity,
              color: const Color.fromARGB(143, 226, 147, 57),
              child: const Text(
                "Rentrer les parametres de l'enfant, basculer en mois si besoin pour l'age et cliquer sur calculer pour obtenir les résultats",
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
          const SizedBox(height: 16),
          if (constantesPhysiologiques != null) ...[
            const Text(
              'Constantes Physiologiques',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              //color: Colors.black,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      opacity: 1,
                      image: AssetImage("assets/images/ecg.jpg"),
                      fit: BoxFit.cover)),
              height: 200,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        'FC: ${constantesPhysiologiques!['FC']}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 94, 228, 41),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text('FR: ${constantesPhysiologiques!['FR']}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      Text('PAS - PAD: ${constantesPhysiologiques!['PAS']}',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                          'Hypotension: ${constantesPhysiologiques!['Hypotension']}',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 235, 59, 241),
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      const Spacer(),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (taillesonde != null) ...[
            const Text(
              "Ventilation",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Circuit: ${circuit!['circuit']}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Ballon: ${ballon!['ballon']}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Taille Sonde IOT: ${taillesonde!['taillesonde']}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Taille Sonde d'aspiration: ${tailleaspi!['tailleaspi']}",
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
            Text(
              'Fréquence Respiratoire: ${constantesPhysiologiques!['FR']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
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
                  const Row(
                    children: [
                      Spacer(),
                      Text(
                        'Doses Induction',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                    ],
                  ),

                  const SizedBox(height: 4),
                  //container des hypnotiques
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.yellow,
                        width: 1,
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
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Propofol: $dosePropofolmini - $dosePropofolmaxi mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text("2 à 5 mg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Etomidate: ${doseEtomidate!.toStringAsFixed(1)} mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(
                                "0,2 mg/kg",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ketamine: ${doseKetaminemini!.toStringAsFixed(1)} - ${doseKetaminemaxi!.toStringAsFixed(1)} mg",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text("2 mg/kg pour induction IV",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ketamine:  ${doseketaNMDA!.toStringAsFixed(1)} mg",
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text("0.2 mg/kg (anti NMDA)",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                  //container bleu des morphiniques
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade700, width: 1),
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
                        const SizedBox(height: 7),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sufentanyl: ${doseSufentamini!.toStringAsFixed(1)} - ${doseSufentamaxi!.toStringAsFixed(1)} µg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text("0,2 mcg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alfentanyl: $doseAlfentanylmini - $doseAlfentanylmaxi µg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 20 à 40 mcg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Remifentanyl: ${doseRemifentanylmini!.toStringAsFixed(1)} - ${doseRemifentanylmaxi!.toStringAsFixed(1)} µg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 20 à 40 mcg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fentanyl: $doseFentanylmini - $doseFentanylmaxi µg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 20 à 50 mcg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  //container rouge des curares
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade700, width: 1),
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
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cisatracrium: ${doseCisatracrium!.toStringAsFixed(1)} mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 0,15 à 0,2 mg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Celocurine: $doseCelocurinemini mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text("1 mg/kg (2mg/kg si age<24 mois) ",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Atracrium: ${doseAtracrium!.toStringAsFixed(1)} mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 0,5 mg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rocuronium: ${doseRocuroniummini!.toStringAsFixed(0)} - ${doseRocuroniummaxi!.toStringAsFixed(0)} mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 0,6 mg/kg ou 1 à 1.2mg/kg en ISR",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                  //container rouge des antalgiques
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.purple.shade400, width: 1),
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
                        ExpansionTile(
                          title: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Noradrénaline',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              child: const Text(
                                  'Noradre 3mg(1,5ml) + Séreum phy 48,5ml soit 0,06mg/ml => 0.1-0.3mcg/kg/min = O.1-0.3ml/kg/h'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                  //container violet des amines
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.green.shade400, width: 1),
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
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Paracétamol: ${doseParacetamol!.toStringAsFixed(0)} mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 15 mg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Profénid: $doseProfenid mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 1 mg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nalbuphine: ${doseNalbuphine!.toStringAsFixed(1)} mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 0.2 mg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Morphine: ${doseMorphine!.toStringAsFixed(1)}  mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 0.1 mg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 211, 173, 47),
                          width: 1),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Remplissage:",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ExpansionTile(
                                expandedAlignment: Alignment.topLeft,
                                title: Text(
                                  'Apport Liquidien de base: $apportLiquidien ml/h ',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Méthode de calcul des apports de base 4 2 1",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Attention, cette règle ne prend pas en compte les pertes insensibles et la compensation du jeûne",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Compensation du jeune: Durée du jeune x besoin horaire = volume à compenser",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "Passer 50% de ce volume la première heure et 50% sur la deuxième heure",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              ExpansionTile(
                                expandedAlignment: Alignment.topLeft,
                                title: Text(
                                  'Bolus de $remplissagevasc ml de cristalloides en 20 à 30min',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "10 à 20ml/kg en 20 à 30 min",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "Remplissage de SSI ou RL",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              ExpansionTile(
                                expandedAlignment: Alignment.topLeft,
                                title: const Text(
                                  'Quel soluté pour quel enfant ? ',
                                  style: TextStyle(fontSize: 14),
                                ),
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Isopédia",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "RL possible après 4 ans",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 8, 8, 8), width: 1),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Divers:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dexamétasone: ${doseDexametasone!.toStringAsFixed(1)}  mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 0.15 mg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ondansetron: ${doseOndansetron!.toStringAsFixed(1)}  mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 0.1 mg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Narcan: ${doseNarcan!.toStringAsFixed(1)}  mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(" 0.1 mg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hydrocortisone:  mg',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text("20 mg/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.right),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            if (dosePropofolmini != null && dosePropofolmaxi != null) ...[
              Container(
                padding: const EdgeInsets.all(5),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: const Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Equipements",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Catheter arteriel',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Catheter veineux central',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Sonde urinaire  ',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Drain thoracique ',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]
          ],
        ],
      ),
    );
  }
}
