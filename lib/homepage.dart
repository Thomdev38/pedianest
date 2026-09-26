// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:pedianesth/antibiotique.dart';

// ignore: unused_import
import 'package:pedianesth/english/mainen.dart';
import 'package:pedianesth/entretien.dart';
import 'package:pedianesth/main.dart';
import 'package:pedianesth/responsive.dart';
import 'package:pedianesth/reperes_pediatriques.dart';
import 'package:pedianesth/memo_pediatrique.dart';
import 'package:pedianesth/posologies_fr.dart';

String _pertesPourPoids(int poids, Chirurgie chirurgie) {
  final pertes = calculerPertesChirurgicales(poids, chirurgie);
  final volume = pertes.minimum == pertes.maximum
      ? formaterNombre(pertes.minimum)
      : '${formaterNombre(pertes.minimum)} à ${formaterNombre(pertes.maximum)}';
  return 'Pour $poids kg : $volume ml/h';
}

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
  Map<String, String>? ktarteriel;
  Map<String, String>? vvc;
  Map<String, String>? sad;

  bool isAgeInMonths = false;
  int? dosePropofolmini;
  double? hypotensionsup1;
  int? dosePropofolmaxi;
  double? doseEtomidate;
  int? doseKetaminemini;
  int? doseKetaminemaxi;
  double? doseSufentamini;
  double? doseSufentamaxi;
  int? doseAlfentanylmini;
  int? doseAlfentanylmaxi;
  double? debitRemifentanilMinUgMin;
  double? debitRemifentanilMaxUgMin;
  int? doseFentanylmini;
  int? doseFentanylmaxi;
  double? doseCisatracrium;
  double? doseCelocurinemini;
  double? doseCelocurinemaxi;
  double? doseAtracrium;
  double? doseRocuroniummini;
  double? doseRocuroniummaxi;
  int? apportLiquidien;
  int? vtmin;
  int? vtmax;
  double? repereiot;
  int? celo;
  int? dosecordarone;
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
  double? doseGluconateCamin;
  double? doseGluconateCamax;
  double? doseminFibri;
  double? dosemaxFibri;
  double? doseOramorph;
  double? doseSkenan;
  double? doseActiskenan;
  int? doseAdvil;
  int? doseSpasfon;
  double? doseDroleptan;
  double? doseManitol;
  double? doseSshmin;
  double? doseSshmax;
  double? doseValium;
  double? doseRivotril;
  double? doseneomin;
  int? doseneomax;

  Map<String, String> obtenirKtarteriel(int poids) {
    if (poids < 1) {
      return {'kt arteriel': '1 Fr (24Ga)'};
    } else if (poids < 10) {
      return {'kt arteriel': '3 Fr (24Ga)'};
    } else if (poids < 20) {
      return {'kt arteriel': '3 Fr (20Ga)'};
    } else if (poids < 30) {
      return {'kt arteriel': '4 Fr (20Ga ou 18Ga)'};
    } else {
      return {'kt arteriel': '5 Fr (18Ga)'};
    }
  }

  Map<String, String> obtenirVvc(int poids) {
    if (poids < 2) {
      return {'vvc': '2 - 3 Fr'};
    } else if (poids < 4) {
      return {'vvc': '3 - 4 Fr '};
    } else if (poids < 10) {
      return {'vvc': '4 - 5 Fr'};
    } else if (poids < 20) {
      return {'vvc': '5 - 6 Fr'};
    } else if (poids < 40) {
      return {'vvc': '6 - 7 Fr'};
    } else {
      return {'vvc': '7 - 8.5 Fr'};
    }
  }

  Map<String, String> obtenirBallon(int poids) {
    if (poids <= 10) {
      return {'ballon': '0,5 litre'};
    } else if (poids <= 20) {
      return {'ballon': '1 litre'};
    } else if (poids <= 30) {
      return {'ballon': '2 litres'};
    } else {
      return {'ballon': 'adulte'};
    }
  }

  Map<String, String> obtenirtauxhb(int ageEnMois) {
    if (ageEnMois < 1) {
      return {'hb': '17 g/dl'};
    } else if (ageEnMois < 2) {
      return {'hb': '14 g/dl'};
    } else if (ageEnMois < 3) {
      return {'hb': '10 - 11 g/dl (anemie physiologique)'};
    } else if (ageEnMois < 24) {
      return {'hb': '12 g/dl'};
    } else if (ageEnMois < 72) {
      return {'hb': '13.5 g/dl'};
    } else {
      return {'hb': '14 g/dl'};
    }
  }

  Map<String, String> obtenirsad(int ageEnMois) {
    if (ageEnMois < 1) {
      return {'sad': '5 - 6 Fr'};
    } else if (ageEnMois < 2) {
      return {'sad': '6 - 8 Fr'};
    } else if (ageEnMois < 12) {
      return {'sad': '6 - 8 Fr'};
    } else if (ageEnMois < 36) {
      return {'sad': '8 Fr'};
    } else if (ageEnMois < 72) {
      return {'sad': '8 - 10 Fr'};
    } else if (ageEnMois < 120) {
      return {'sad': '10 - 12 Fr'};
    } else if (ageEnMois < 192) {
      return {'sad': '12 - 14 Fr'};
    } else {
      return {'sad': '14 - 16 Fr'};
    }
  }

  Map<String, String> obtenirtaillesonde(int poids) {
    if (poids <= 4) {
      return {'taillesonde': '2.5 a 3.0'};
    } else if (poids <= 9) {
      return {'taillesonde': '3.5'};
    } else if (poids <= 14) {
      return {'taillesonde': '4.0'};
    } else if (poids <= 19) {
      return {'taillesonde': '4.5'};
    } else if (poids <= 24) {
      return {'taillesonde': '5.0'};
    } else if (poids <= 29) {
      return {'taillesonde': '5.5'};
    } else if (poids <= 34) {
      return {'taillesonde': '6.0'};
    } else if (poids <= 39) {
      return {'taillesonde': '6.5'};
    } else {
      return {'taillesonde': '7.0'};
    }
  }

  Map<String, String> obtenirTailleLame(int poids) {
    if (poids <= 5) {
      return {'taillelame': '0 - 1'};
    } else if (poids <= 10) {
      return {'taillelame': '1'};
    } else if (poids <= 12) {
      return {'taillelame': '1 - 2'};
    } else if (poids <= 34) {
      return {'taillelame': '2'};
    } else {
      return {'taillelame': '3'};
    }
  }

  Map<String, String> obtenirTailleAspi(int poids) {
    if (poids < 5) {
      return {'tailleaspi': '6 - 8'};
    } else if (poids <= 10) {
      return {'tailleaspi': '8'};
    } else if (poids <= 15) {
      return {'tailleaspi': '10'};
    } else if (poids <= 20) {
      return {'tailleaspi': '12'};
    } else if (poids <= 35) {
      return {'tailleaspi': '14'};
    } else {
      return {'tailleaspi': '16'};
    }
  }

  void calculerDosesEtSonde() {
    final int age = int.tryParse(ageController.text) ?? 0;
    final int ageEnMois = convertirAgeEnMois(age, enMois: isAgeInMonths);
    final int poids = int.tryParse(poidsController.text) ?? 0;

    setState(() {
      hypotensionsup1 = calculerSeuilHypotension(ageEnMois);
      dosePropofolmini = poids * 2;
      dosePropofolmaxi = poids * 5;
      doseEtomidate = poids * 0.2;
      doseKetaminemini = poids * 2;
      doseKetaminemaxi = poids * 4;
      doseSufentamini = poids * 0.2;
      doseSufentamaxi = poids * 0.4;
      doseAlfentanylmini = poids * 20;
      doseAlfentanylmaxi = poids * 40;
      debitRemifentanilMinUgMin = poids * 0.2;
      debitRemifentanilMaxUgMin = poids * 0.5;
      doseFentanylmini = poids * 20;
      doseFentanylmaxi = poids * 50;
      doseCisatracrium = poids * 0.2;
      doseParacetamol = poids * 15;
      doseProfenid = poids;
      doseMorphine = poids * 0.1;
      doseNalbuphine = calculerNalbuphineMg(poids, ageEnMois);
      dosePropofolEntretien = poids * 10.0;
      doseAdrenaline = poids * 0.01;
      doseAtropine = poids * 0.02;
      poidstext = poids * 1;
      agemoistext = ageEnMois * 1;
      remplissagevasc = poids * 20;
      doseDexametasone = poids * 0.15;
      doseNarcan = poids * 10;
      doseketaNMDA = poids * 0.2;
      doseExacyl = calculerExacyl(poids).chargeMg;
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
      dosecordarone = poids * 5;
      doseVancomycinemini = poids * 20;
      doseVancomycinemaxi = poids * 30;
      doseminPFC = poids * 10;
      dosemaxPFC = poids * 30;
      doseminPqt = poids * 15;
      dosemaxPqt = poids * 20;
      doseOndansetron = poids * 0.1;
      doseGluconateCamin = poids * 7.5;
      doseGluconateCamax = poids * 15;
      final fibrinogene = calculerFibrinogeneGrammes(poids);
      doseminFibri = fibrinogene.minimum;
      dosemaxFibri = fibrinogene.maximum;
      doseOramorph = poids * 0.2;
      doseActiskenan = poids * 1;
      doseSkenan = poids * 1;
      doseAdvil = poids * 10;
      doseSpasfon = poids;
      doseDroleptan = poids * 20;
      doseManitol = poids * 0.5;
      doseSshmin = poids * 6.5;
      doseSshmax = poids * 10;
      doseValium = poids * 0.5;
      doseRivotril = poids * 0.05;
      final succinylcholine = calculerSuccinylcholineIVMg(poids, ageEnMois);
      doseCelocurinemini = succinylcholine.minimum;
      doseCelocurinemaxi = succinylcholine.maximum;
      final phenylephrine = calculerPhenylephrineMicrogrammes(poids);
      doseneomin = phenylephrine.minimum;
      doseneomax = phenylephrine.maximum;

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
      sad = obtenirsad(ageEnMois);
      taillesonde = obtenirtaillesonde(poids);
      tailleguedel = obtenirTailleguedel(ageEnMois);
      hb = obtenirtauxhb(ageEnMois);
      vvc = obtenirVvc(poids);
      ktarteriel = obtenirKtarteriel(poids);
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
          bottom: TabBar(
            isScrollable: !Responsive.isWide(context),
            dividerColor: AppColors.lightBlue,
            indicatorWeight: 3.0,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: 'Anesthesie'),
              Tab(text: 'Urgences'),
              Tab(text: "Antibiotiques/ ALR"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InductionPage(
              poidstext: poidstext,
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
              debitRemifentanilMinUgMin: debitRemifentanilMinUgMin,
              debitRemifentanilMaxUgMin: debitRemifentanilMaxUgMin,
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
              dosecordarone: dosecordarone,
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
              ktarteriel: ktarteriel,
              tailleaspi: tailleaspi,
              tailleguedel: tailleguedel,
              sad: sad,
              vvc: vvc,
              remplissagevasc: remplissagevasc,
              doseDexametasone: doseDexametasone,
              doseNarcan: doseNarcan,
              doseketaNMDA: doseketaNMDA,
              doseOndansetron: doseOndansetron,
              hypotensionsup1: hypotensionsup1,
              agemoistext: agemoistext,
              doseOramorph: doseOramorph,
              doseSkenan: doseSkenan,
              doseActiskenan: doseActiskenan,
              doseAdvil: doseAdvil,
              doseSpasfon: doseSpasfon,
              doseDroleptan: doseDroleptan,
              doseneomin: doseneomin,
              doseneomax: doseneomax,
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
              doseGluconateCamin: doseGluconateCamin,
              doseGluconateCamax: doseGluconateCamax,
              dosemaxFibri: dosemaxFibri,
              doseminFibri: doseminFibri,
              doseManitol: doseManitol,
              doseSshmin: doseSshmin,
              doseSshmax: doseSshmax,
              doseValium: doseValium,
              doseRivotril: doseRivotril,
              doseExacyl: doseExacyl,
            ),
            AntibioPage(
              dosePropofolEntretien: dosePropofolEntretien,
              poidstext: poidstext,
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

// Helper widget for medical section cards
class _MedicalSection extends StatelessWidget {
  final String title;
  final Color borderColor;
  final Color? backgroundColor;
  final IconData? icon;
  final List<Widget> children;

  const _MedicalSection({
    required this.title,
    required this.borderColor,
    this.backgroundColor,
    this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: borderColor, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: borderColor, size: 20),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: borderColor.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}

// Helper widget for drug dose display
class _DoseRow extends StatelessWidget {
  final String name;
  final String dose;
  final String? hint;

  const _DoseRow({
    required this.name,
    required this.dose,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name: $dose',
            style: const TextStyle(fontSize: 15, color: AppColors.textDark),
          ),
          if (hint != null)
            Text(
              hint!,
              style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
            ),
        ],
      ),
    );
  }
}

class _PertesChirurgicalesRow extends StatelessWidget {
  const _PertesChirurgicalesRow({
    required this.niveau,
    required this.taux,
    required this.estimation,
  });

  final String niveau;
  final String taux;
  final String? estimation;

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.pastelOrange.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.pastelOrange.withValues(alpha: 0.45),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(niveau, style: const TextStyle(fontSize: 14,
                fontWeight: FontWeight.w600, color: AppColors.textDark)),
            const SizedBox(height: 3),
            Text(taux, style: const TextStyle(fontSize: 12,
                color: AppColors.textMuted)),
            if (estimation != null) ...[
              const SizedBox(height: 8),
              Text(estimation!, style: const TextStyle(fontSize: 15,
                  fontWeight: FontWeight.bold, color: AppColors.textDark)),
            ],
          ],
        ),
      );
}

// ignore: must_be_immutable
class InductionPage extends StatelessWidget {
  final int? poidstext;
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
  final double? debitRemifentanilMinUgMin;
  final double? debitRemifentanilMaxUgMin;
  final int? dosecordarone;
  final int? doseFentanylmini;
  final int? doseFentanylmaxi;
  final double? doseCisatracrium;
  final double? doseCelocurinemini;
  final double? doseCelocurinemaxi;
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
  final Map<String, String>? ktarteriel;
  final Map<String, String>? vvc;
  final Map<String, String>? sad;
  final int? agemoistext;
  final double? hypotensionsup1;
  final double? doseDexametasone;
  final double? doseketaNMDA;
  final double? doseOndansetron;
  final double? doseOramorph;
  final double? doseSkenan;
  final double? doseActiskenan;
  final int? doseAdvil;
  final int? doseSpasfon;
  final double? doseDroleptan;
  final double? doseneomin;
  final int? doseneomax;

  const InductionPage({
    required this.poidstext,
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
    required this.debitRemifentanilMinUgMin,
    required this.debitRemifentanilMaxUgMin,
    required this.doseFentanylmini,
    required this.doseFentanylmaxi,
    required this.doseCisatracrium,
    required this.dosecordarone,
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
    required this.ktarteriel,
    required this.remplissagevasc,
    required this.doseDexametasone,
    required this.doseNarcan,
    required this.doseketaNMDA,
    required this.doseOndansetron,
    required this.hypotensionsup1,
    required this.agemoistext,
    required this.doseOramorph,
    required this.doseActiskenan,
    required this.doseSkenan,
    required this.doseAdvil,
    required this.doseDroleptan,
    required this.doseSpasfon,
    required this.vvc,
    required this.doseneomax,
    required this.doseneomin,
    required this.sad,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          // Input Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Parametres du patient',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    prefixIcon: Icon(Icons.cake_outlined, color: AppColors.primaryBlue),
                  ),
                ),
                SwitchListTile(
                  title: const Text('Age en mois', style: TextStyle(fontSize: 14)),
                  value: isAgeInMonths,
                  onChanged: onSwitchChanged,
                  activeColor: AppColors.accentTeal,
                  contentPadding: EdgeInsets.zero,
                ),
                TextField(
                  controller: poidsController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Poids (kg)',
                    prefixIcon: Icon(Icons.monitor_weight_outlined, color: AppColors.primaryBlue),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onCalculate,
                    icon: const Icon(Icons.calculate_outlined),
                    label: const Text('Calculer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          if (constantesPhysiologiques == null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.pastelOrange.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.pastelOrange.withValues(alpha: 0.6)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.textMuted),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Rentrer les parametres de l'enfant, basculer en mois si besoin pour l'age et cliquer sur calculer pour obtenir les resultats",
                      style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textDark),
                    ),
                  ),
                ],
              ),
            )
          ],

          ResponsiveMasonry(children: [
          // Constantes Physiologiques
          if (constantesPhysiologiques != null) ...[
            _MedicalSection(
              title: 'Constantes Physiologiques',
              borderColor: AppColors.pastelPink,
              icon: Icons.monitor_heart_outlined,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      opacity: 1,
                      image: AssetImage("assets/images/ecg.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  constraints: const BoxConstraints(minHeight: 180),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'FC: ${constantesPhysiologiques!['FC']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'FR: ${constantesPhysiologiques!['FR']}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'PAS - PAD: ${constantesPhysiologiques!['PAS']}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (constantesPhysiologiques!.containsKey('Hypotension'))
                        Text(
                          'Hypotension: ${constantesPhysiologiques!['Hypotension']}',
                          style: const TextStyle(
                            color: Color(0xFFE040FB),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],

          // Ventilation
          if (taillesonde != null) ...[
            _MedicalSection(
              title: 'Ventilation',
              borderColor: AppColors.lightBlue,
              icon: Icons.air_outlined,
              children: [
                _DoseRow(name: 'Circuit', dose: '${circuit!['circuit']}'),
                _DoseRow(name: 'Ballon', dose: '${ballon!['ballon']}'),
                _DoseRow(name: 'Taille Sonde IOT', dose: '${taillesonde!['taillesonde']}'),
                _DoseRow(name: "Taille Sonde d'aspiration", dose: '${tailleaspi!['tailleaspi']}'),
                if (taillelame != null)
                  _DoseRow(name: 'Taille Lame', dose: '${taillelame!['taillelame']}'),
                _DoseRow(name: 'Taille Guedel', dose: '${tailleguedel!['tailleguedel']}'),
                if (repereiot != null)
                  _DoseRow(name: 'Repere IOT', dose: '${repereiot!.toStringAsFixed(0)} cm'),
                if (vtmin != null && vtmax != null) ...[
                  _DoseRow(name: 'Volume courant', dose: '$vtmin - $vtmax ml'),
                  _DoseRow(name: 'Frequence Respiratoire', dose: '${constantesPhysiologiques!['FR']}'),
                ],
              ],
            ),
          ],
          ]),

          const MemoPediatrique(),

          // Doses d’anesthésie
          if (dosePropofolmini != null && dosePropofolmaxi != null) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  'Doses d’anesthésie',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
              ),
            ),

            ResponsiveMasonry(children: [
            // Hypnotiques
            _MedicalSection(
              title: 'Hypnotiques',
              borderColor: AppColors.pastelYellow,
              icon: Icons.bedtime_outlined,
              children: [
                _DoseRow(name: 'Propofol', dose: '$dosePropofolmini - $dosePropofolmaxi mg', hint: '2 a 5 mg/kg'),
                _DoseRow(name: 'Etomidate', dose: '${doseEtomidate!.toStringAsFixed(1)} mg', hint: '0,2 mg/kg'),
                _DoseRow(name: 'Ketamine', dose: '${doseKetaminemini!.toStringAsFixed(0)} - ${doseKetaminemaxi!.toStringAsFixed(0)} mg', hint: '2 mg/kg pour induction IV'),
                _DoseRow(name: 'Ketamine', dose: '${doseketaNMDA!.toStringAsFixed(1)} mg', hint: '0.2 mg/kg (anti NMDA)'),
              ],
            ),

            // Morphiniques
            _MedicalSection(
              title: 'Morphiniques',
              borderColor: AppColors.primaryBlue,
              icon: Icons.vaccines_outlined,
              children: [
                _DoseRow(name: 'Sufentanyl', dose: '${doseSufentamini!.toStringAsFixed(1)} - ${doseSufentamaxi!.toStringAsFixed(1)} mcg', hint: '0,2 mcg/kg'),
                _DoseRow(name: 'Alfentanyl', dose: '$doseAlfentanylmini - $doseAlfentanylmaxi mcg', hint: '20 a 40 mcg/kg'),
                _DoseRow(name: 'Fentanyl', dose: '$doseFentanylmini - $doseFentanylmaxi mcg', hint: '20 a 50 mcg/kg'),
              ],
            ),

            // Débit IV distinct des doses isolées de morphiniques.
            _MedicalSection(
              title: 'Rémifentanil — perfusion IV',
              borderColor: AppColors.primaryBlue,
              icon: Icons.water_drop_outlined,
              children: [
                _DoseRow(
                  name: 'Débit',
                  dose: '${debitRemifentanilMinUgMin!.toStringAsFixed(1)} - ${debitRemifentanilMaxUgMin!.toStringAsFixed(1)} µg/min',
                  hint: '0,2 à 0,5 µg/kg/min — adapter à la réponse clinique.',
                ),
              ],
            ),

            // Curares
            _MedicalSection(
              title: 'Curares',
              borderColor: AppColors.pastelRed,
              icon: Icons.fitness_center_outlined,
              children: [
                _DoseRow(name: 'Cisatracrium', dose: '${doseCisatracrium!.toStringAsFixed(1)} mg', hint: '0,15 a 0,2 mg/kg'),
                _DoseRow(
                  name: 'Célocurine / succinylcholine — intubation IV',
                  dose: doseCelocurinemini == doseCelocurinemaxi
                      ? '${formaterNombre(doseCelocurinemini!)} mg IV'
                      : '${formaterNombre(doseCelocurinemini!)} à ${formaterNombre(doseCelocurinemaxi!)} mg IV',
                  hint: agemoistext! < 12
                      ? 'Âge <12 mois : 2 mg/kg IV pour intubation.'
                      : 'Âge ≥12 mois : 1 à 1,5 mg/kg IV pour intubation.',
                ),
                _DoseRow(name: 'Atracrium', dose: '${doseAtracrium!.toStringAsFixed(1)} mg', hint: '0,5 mg/kg'),
                _DoseRow(name: 'Rocuronium', dose: '${doseRocuroniummini!.toStringAsFixed(0)} - ${doseRocuroniummaxi!.toStringAsFixed(0)} mg', hint: '0,6 mg/kg ou 1 a 1.2mg/kg en ISR'),
              ],
            ),

            // Cardiovasculaire
            _MedicalSection(
              title: 'Cardiovasculaire',
              borderColor: AppColors.pastelPurple,
              icon: Icons.favorite_outline,
              children: [
                _DoseRow(name: 'Adrenaline', dose: '${doseAdrenaline!.toStringAsFixed(2)} mg'),
                _DoseRow(name: 'Atropine', dose: '${doseAtropine!.toStringAsFixed(2)} mg'),
                _DoseRow(name: 'Néosynéphrine / phényléphrine', dose: '${doseneomin!.toStringAsFixed(1)} - ${doseneomax!} µg', hint: 'Bolus : 0,5 à 2 µg/kg ; maximum : 10 µg/kg'),
                _DoseRow(name: 'Cordarone', dose: '${dosecordarone!} mg IVL sur 20min', hint: '5 mg/kg'),
                const ExpansionTile(
                  title: Text('Noradrenaline', style: TextStyle(fontSize: 15, color: AppColors.textDark)),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('poids en kg x 0,15 = mg de noradre a ramener dans 25 ml', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text('1 ml/h = 0,1 mcg/kg/mn', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text('Posologie : 0,05 a 2 mcg/kg/mn', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
                const ExpansionTile(
                  title: Text('Dobutamine', style: TextStyle(fontSize: 15, color: AppColors.textDark)),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('poids en kg x 15 = mg de dobu a ramener dans 25 ml', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text('0,1 ml/h = 1 mcg/kg/mn', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text('Posologie : 5 a 20 mcg/kg/mn', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
                const ExpansionTile(
                  title: Text('Ephedrine', style: TextStyle(fontSize: 15, color: AppColors.textDark)),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('300 mcg/kg', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text('pas diluee si poids > 10 kg, dilution 300 mcg/ml si < 10kg)', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text('Peu efficace en dessous de 1 an', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
                const _DoseRow(name: 'Xylocaine', dose: '1 mg/kg'),
                const _DoseRow(name: 'Defibrillateur', dose: '2J/kg puis 4J/kg si echec'),
              ],
            ),

            // Antalgiques
            _MedicalSection(
              title: 'Antalgiques',
              borderColor: AppColors.pastelGreen,
              icon: Icons.healing_outlined,
              children: [
                _DoseRow(name: 'Paracetamol', dose: '${doseParacetamol!.toStringAsFixed(0)} mg', hint: '15 mg/kg'),
                if (agemoistext! >= 12)
                  _DoseRow(name: 'Profenid', dose: '$doseProfenid mg', hint: '0.5 - 1 mg/kg'),
                if (agemoistext! >= 3)
                  _DoseRow(name: 'Advil/ibuprofene', dose: '$doseAdvil mg', hint: '10mg/kg/8h max 400mg/prise'),
                _DoseRow(name: 'Nalbuphine', dose: '${doseNalbuphine!.toStringAsFixed(1)} mg', hint: '${tauxNalbuphineMgKg(agemoistext!).toStringAsFixed(1).replaceAll(".", ",")} mg/kg (${agemoistext! < 6 ? "âge <6 mois" : "âge ≥6 mois"})'),
                if (agemoistext! >= 180)
                  const _DoseRow(name: 'Acupan', dose: '1 ampoule 4 a 6/jour'),
                if (agemoistext! >= 6)
                  _DoseRow(name: 'Oramorph', dose: '${doseOramorph!.toStringAsFixed(1)} mg', hint: '0.2 mg/kg toute les 4 a 6h'),
                if (agemoistext! >= 6)
                  _DoseRow(name: 'Actiskenan', dose: '${doseActiskenan!.toStringAsFixed(0)} mg', hint: '1 mg/kg/j en 6 prises'),
                if (agemoistext! >= 6)
                  _DoseRow(name: 'Skenan lp', dose: '${doseSkenan!.toStringAsFixed(0)} mg', hint: '1 mg/kg/j en 2 prises'),
                _DoseRow(
                  name: 'Morphine IV postopératoire — dose de charge',
                  dose: '${doseMorphine!.toStringAsFixed(1)} mg IV lente',
                  hint: '0,1 mg/kg',
                ),
                _DoseRow(
                  name: 'Morphine — bolus de titration après la charge',
                  dose: '${poidstext! * 25} à ${poidstext! * 50} µg par bolus',
                  hint: '25 à 50 µg/kg. Réévaluation toutes les 5 minutes selon protocole et réponse clinique.',
                ),
                _DoseRow(
                  name: 'Naloxone',
                  dose: "titration de 40mcg jusqu'a ${doseNarcan!.toStringAsFixed(0)} mcg",
                  hint: "Diluer 1 amp de 0.4mg dans 10ml, injecter bolus de 40mcg jusqu'a ${doseNarcan!.toStringAsFixed(0)} mcg. Poursuivre avec ${doseNarcan!.toStringAsFixed(0)}mcg/h soit 10 mcg/kg/h",
                ),
              ],
            ),

            // Remplissage
            _MedicalSection(
              title: 'Fluidothérapie',
              borderColor: AppColors.pastelOrange,
              icon: Icons.water_drop_outlined,
              children: [
                const Text('Pour la fluidothérapie périopératoire pédiatrique : cristalloïde isotoniquement équilibré en première intention.'),
                const SizedBox(height: 8),
                const Text('En chirurgie élective avec un jeûne conforme aux recommandations actuelles, la compensation systématique d’un déficit de jeûne n’est généralement pas nécessaire. Adapter les apports à l’état volémique, aux pertes et au contexte clinique.'),
                const SizedBox(height: 8),
                const Text('Pertes chirurgicales', style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(height: 4),
                const Text('Estimations à adapter au contexte clinique, pas une prescription automatique.',
                    style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                for (final chirurgie in Chirurgie.values)
                  _PertesChirurgicalesRow(
                    niveau: '${chirurgie.libelle[0].toUpperCase()}${chirurgie.libelle.substring(1)}',
                    taux: chirurgie.taux,
                    estimation: poidstext != null && poidstext! > 0
                        ? _pertesPourPoids(poidstext!, chirurgie)
                        : null,
                  ),
                ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  title: Text(
                    'Apport Liquidien de base: $apportLiquidien ml/h',
                    style: const TextStyle(fontSize: 14, color: AppColors.textDark),
                  ),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Apports de base — règle 4-2-1 : 0 à 10 kg : 4 ml/kg/h ; >10 à 20 kg : 40 ml/h + 2 ml/kg/h par kg au-delà de 10 ; >20 kg : 60 ml/h + 1 ml/kg/h par kg au-delà de 20.", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          SizedBox(height: 8),
                          Text("Ce calcul des apports de base ne comprend pas les pertes chirurgicales.", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  title: Text(
                    'Bolus de $remplissagevasc ml de cristalloides en 20 a 30min',
                    style: const TextStyle(fontSize: 14, color: AppColors.textDark),
                  ),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("10 a 20ml/kg en 20 a 30 min", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text("Remplissage de SSI ou RL", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
                const ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  title: Text(
                    'Quel solute pour quel enfant ?',
                    style: TextStyle(fontSize: 14, color: AppColors.textDark),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Références spécifiques existantes — à valider selon le protocole local :", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text("Isopédia", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text("RL possible apres 4 ans", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Divers
            _MedicalSection(
              title: 'Divers',
              borderColor: AppColors.textMuted,
              icon: Icons.more_horiz,
              children: [
                if (agemoistext! >= 24)
                  _DoseRow(name: 'Dexametasone', dose: '${doseDexametasone!.toStringAsFixed(1)} mg', hint: '0.15 mg/kg'),
                if (agemoistext! >= 1)
                  _DoseRow(name: 'Ondansetron', dose: '${doseOndansetron!.toStringAsFixed(1)} mg', hint: '0.1 mg/ x 3/jour'),
                if (agemoistext! >= 24)
                  _DoseRow(name: 'Droleptan', dose: '${doseDroleptan!.toStringAsFixed(0)} mcg', hint: '20 mcg/kg (pas pour enfant en ambulatoire)'),
                _DoseRow(name: 'Spasfon', dose: '${doseSpasfon!} mg', hint: '1 mg/kg/6h'),
              ],
            ),

            // Equipements
            _MedicalSection(
              title: 'Equipements',
              borderColor: const Color(0xFF8B7EC8),
              icon: Icons.medical_services_outlined,
              children: [
                _DoseRow(name: 'kt Arteriel', dose: '${ktarteriel!['kt arteriel']}'),
                _DoseRow(name: 'Catheter veineux central', dose: '${vvc!['vvc']}'),
                _DoseRow(name: 'Sonde urinaire', dose: '${sad!['sad']}'),
              ],
            ),
            ]),
          ],
        ],
        ),
      ),
    );
  }
}
