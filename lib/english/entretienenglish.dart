import "package:flutter/material.dart";

class UrgenceEnglish extends StatelessWidget {
  final double? dosePropofolEntretien; // Recevoir la variable du parent
  final int? poidstext;

  const UrgenceEnglish({
    super.key,
    this.dosePropofolEntretien,
    this.poidstext,
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
                "Veuillez rentrer le poids et l'age de l'enfant pour obtenir les médicaments suivant"),
          if (dosePropofolEntretien != null)
            Text(
              'Pour un enfant de: ${poidstext!} kg voici les doses recommandés',
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
                //container des hypnotiques
                const Text("Exacyl"),
                const SizedBox(
                  height: 6,
                ),
                const Text("Gluconate de calcium"),
                const SizedBox(
                  height: 6,
                ),
                const Text("Hydrocortisone"),
                const SizedBox(
                  height: 6,
                ),
                const Text("Solumédrol"),
                const SizedBox(
                  height: 6,
                ),
                const Text("Manitol"),
                const SizedBox(
                  height: 6,
                ),
                const Text("bupivacaine"),
                const SizedBox(
                  height: 6,
                ),
                const Text("Naropeine"),
                const SizedBox(
                  height: 6,
                ),
                const Text("Lidocaine"),
                const SizedBox(
                  height: 6,
                ),

                const SizedBox(height: 4),
                //container bleu des morphiniques
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade700, width: 5),
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(3),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Morphiniques:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Curares:",
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
        ]));
  }
}
