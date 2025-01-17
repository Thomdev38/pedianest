import "package:flutter/material.dart";

class UrgencePage extends StatelessWidget {
  final double? dosePropofolEntretien; // Recevoir la variable du parent
  final int? poidstext;
  final double? doseExacyl;

  const UrgencePage({
    super.key,
    this.dosePropofolEntretien,
    this.poidstext,
    this.doseExacyl,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),
          if (doseExacyl == null)
            const Text(
                "Veuillez rentrer le poids et l'age de l'enfant sur l'onglet Anesthésie"),
          Image.asset("assets/images/ours.jpg"),
          if (doseExacyl != null)
            Text(
              'Pour un enfant de: ${poidstext!} kg voici les doses recommandés',
              style: const TextStyle(fontSize: 16),
            ),
          if (doseExacyl != null && doseExacyl != null) ...[
            Container(
              padding: const EdgeInsets.all(2),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black54)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  //container des hypnotiques
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Exacyl: $doseExacyl mg',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Text("20 mg/kg",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
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
                        Text(
                          'Gluconate de calcium: $doseExacyl mg',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Text("20 mg/kg",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.right),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 6,
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
                          'Manitol: $doseExacyl mg',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Text("20 mg/kg",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.right),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 6,
                  ),

                  const SizedBox(height: 4),
                  //container bleu des morphiniques

                  const SizedBox(height: 4),
                  //container rouge des curares
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.shade700, width: 5),
                    ),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Blood management:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
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
