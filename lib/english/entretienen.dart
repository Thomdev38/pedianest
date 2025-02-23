import "package:flutter/material.dart";

class UrgenceenPage extends StatelessWidget {
  final double? dosePropofolEntretien; // Recevoir la variable du parent
  final int? poidstext;
  final int? agemoistext;
  final int? dosemaxPFC;
  final int? doseminPFC;
  final int? dosemaxPqt;
  final int? doseminPqt;
  final double? doseGluconateCamin;
  final double? doseGluconateCamax;
  final double? dosemaxFibri;
  final double? doseminFibri;
  final double? doseExacyl;
  final Map<String, String>? hb;
  final double? doseRivotril;
  final double? doseValium;
  final double? doseManitol;
  final double? doseSshmin;
  final double? doseSshmax;

  const UrgenceenPage({
    super.key,
    this.dosePropofolEntretien,
    this.poidstext,
    this.doseminPFC,
    this.dosemaxPFC,
    this.doseminPqt,
    this.dosemaxPqt,
    this.doseExacyl,
    this.agemoistext,
    this.hb,
    this.doseGluconateCamax,
    this.doseGluconateCamin,
    this.dosemaxFibri,
    this.doseminFibri,
    this.doseManitol,
    this.doseRivotril,
    this.doseSshmax,
    this.doseSshmin,
    this.doseValium,
  });

  String getBloodVolume() {
    if (agemoistext == null || poidstext == null) {
      return "Âge ou poids non spécifié";
    }
    double volumePerKg;
    if (agemoistext! < 1) {
      volumePerKg = 95;
    } else if (agemoistext! < 2) {
      volumePerKg = 90;
    } else if (agemoistext! < 13) {
      volumePerKg = 80;
    } else {
      volumePerKg = 70;
    }
    double totalVolume = poidstext! * volumePerKg;
    return "Blood volume estimate: ${totalVolume.toStringAsFixed(0)} ml";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),
          if (doseExacyl == null)
            const Text(
                "Veuillez rentrer le poids et l'age de l'enfant sur l'onglet Anesthésie"),
          if (doseExacyl == null) Image.asset("assets/images/ours.jpg"),
          if (doseExacyl != null)
            Text(
              'Pour un enfant de: ${poidstext!} kg voici les doses recommandés',
              style: const TextStyle(fontSize: 16),
            ),
          if (doseExacyl != null && doseExacyl != null) ...[
            Container(
              padding: const EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  //container des hypnotiques

                  const SizedBox(
                    height: 6,
                  ),

                  const SizedBox(height: 4),
                  //container bleu des morphiniques

                  const SizedBox(height: 4),
                  //container rouge des curares
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade700, width: 1),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Blood management:",
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
                                "Taux d'hémoglobine: ${hb!['hb']}",
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                getBloodVolume(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              ExpansionTile(
                                expandedAlignment: Alignment.topLeft,
                                title: const Text(
                                  'Seuil transfusionnel',
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nouveau-né et nourrisson = 10g/dl",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "Enfant = 8g/dl",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "Si cardiopathie cyanogène: 12g/dl",
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
                                  'Transfusion de CGR',
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Volume en ml de CGR à transfuser = 3 x (Hb souhaitée - Hb observée) x poids (kg)",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  Text(
                                                    "Ratio CGR/PFC/PLQ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Color.fromARGB(
                                                            255, 3, 3, 3)),
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                  Spacer(),
                                                ],
                                              )
                                            ],
                                          ),
                                          Text(
                                            "Si enfant > 30 kg : 1/1/1 (CGR/PFC/PLQ)",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "Si enfant < 30 kg : 30/20/20 ml/kg (CGR/PFC/PLQ)",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Volume PFC:  ${doseminPFC!.toStringAsFixed(0)} - ${dosemaxPFC!.toStringAsFixed(0)} ml",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const Text("10 à 30ml/kg",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Volume plaquettes:  ${doseminPqt!.toStringAsFixed(0)} - ${dosemaxPqt!.toStringAsFixed(0)} ml",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const Text("15 à 20ml/kg",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Fibrinogène:  ${doseminFibri!.toStringAsFixed(2)} - ${dosemaxFibri!.toStringAsFixed(2)} g",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const Text(
                                        "0,03 g/kg jusqu'a 0.06 g/kg si choc hémorragique",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (poidstext! <= 30)
                                      Text(
                                        'Exacyl: ${doseExacyl!.toStringAsFixed(0)} mg ',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    if (poidstext! > 30)
                                      const Text(
                                        'Exacyl: 1g ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    const Text(
                                        "10 mg/kg si <30 kg sinon 1g puis 10mg/kg/h PSE",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Gluconate de calcium: ${doseGluconateCamin!.toStringAsFixed(1)} - ${doseGluconateCamax!.toStringAsFixed(0)}mg',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const Text("7.5 - 15 mg/kg",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),
                  //container vert medoc neurologique
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 155, 209, 127),
                          width: 1),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Neurologie:",
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
                                'Sérum Salé Hypertonique: ${doseSshmin!.toStringAsFixed(1)} à ${doseSshmax!.toStringAsFixed(0)} ml',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text("6.5 à 10ml/kg",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Manitol: $doseManitol à $poidstext g',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const Text("0.5 à 1g/kg sur 20 min",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Si convulsions",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                'Valium: $doseValium mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text("0.5 mg/kg en IR",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.left),
                              const SizedBox(height: 4),
                              Text(
                                'Rivotril: ${doseRivotril!.toStringAsFixed(1)} mg',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text("0.05 mg/kg en IV",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Autres éléments à afficher...
                ],
              ),
            )
          ]
        ]));
  }
}
