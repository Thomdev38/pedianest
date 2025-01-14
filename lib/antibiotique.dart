import "package:flutter/material.dart";

class AntibioPage extends StatelessWidget {
  final double? dosePropofolEntretien; // Recevoir la variable du parent
  final int? poidstext;
  final int? doseLidocaine;
  final int? doseRopivacaine;
  final double? doseBupivacaine;
  final int? dosePrilocaine;
  final int? age;
  final int? isAgeInMonths;

  const AntibioPage({
    super.key,
    this.dosePropofolEntretien,
    this.poidstext,
    this.doseLidocaine,
    this.doseBupivacaine,
    this.doseRopivacaine,
    this.dosePrilocaine,
    this.isAgeInMonths,
    this.age,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Médicaments autres",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (dosePropofolEntretien == null)
            const Text(
                "Veuillez rentrer le poids et l'age de l'enfant pour obtenir les doses d'antibiotiques et d'anesthésiques locaux"),
          if (dosePropofolEntretien != null)
            Text(
              "Pour un enfant de ${poidstext!} kg voici les doses d'antibio-prophylaxie recommandés et d'anesthésiques locaux",
              style: const TextStyle(fontSize: 16),
            ),
          Container(
            padding: const EdgeInsets.all(2),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black54)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                //container anesthesique locaux
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 152, 153, 153),
                        width: 5),
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Anesthésique locaux:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lidocaine: $doseLidocaine mg/6h',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Text("5 mg/kg/6h",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //if (age != null && age! > 6) ...[
                            Text(
                              'Bupivacaine: $doseBupivacaine mg/6h',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Text("2,5 mg/kg/6h",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right),
                            //] else
                            // const Text("Bupivacine non recommandé")
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //if (isAgeInMonths != null &&
                            //isAgeInMonths! > 1) ...[
                            Text(
                              'Ropivacaine: $doseRopivacaine mg/6h',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Text("3 mg/kg/6h",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right),
                            //] else
                            //const Text("Ropivacaine non recommandé")
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if (isAgeInMonths != null &&
                            //isAgeInMonths! > 6) ...[
                            Text(
                              'Prilocaine: $dosePrilocaine mg/6h',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Text("5 mg/kg/6h",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right),
                            //] else
                            // const Text("Prilocaine non recommandé")
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                //container des hypnotiques
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 164, 228, 80),
                      width: 5,
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(3),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Antibioprophylaxie:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cefazoline mg',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text("30 mg/kg, si durée > 4h refaire la même dose",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Amoxicilline/acide clavulanique mg',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                "50 mg/kg (max 2g), si durée > 2h refaire la même dose (max 1g)",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Clindamycine: mg',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                "10 mg/kg (max 900mg), si durée > 4h refaire la même dose (max 450mg à 600mg suivant les indications)",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gentamicyne: mg',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text("6 mg/kg dose unique",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cefoxitine: mg',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                "40 mg/kg (max 2g), si durée > 2h refaire même dose (max 1g)",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Métronidazole: mg',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text("15 mg/kg, dose unique",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vancomycine: mg',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text("20 à 30 mg/kg en 60 minutes, dose unique",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.right),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                //container rouge des curares

                // Autres éléments à afficher...
              ],
            ),
          )
        ]));
  }
}
