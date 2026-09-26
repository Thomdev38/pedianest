/// Repères de la calculette française. Les âges internes sont en mois.
int convertirAgeEnMois(int age, {required bool enMois}) =>
    enMois ? age : age * 12;

double? calculerSeuilHypotension(int ageEnMois) =>
    ageEnMois > 12 ? 70 + 2 * (ageEnMois / 12) : null;

String formaterNombre(num valeur) => valeur == valeur.roundToDouble()
    ? valeur.toInt().toString()
    : valeur.toStringAsFixed(1).replaceAll('.', ',');

int calculerApportLiquidien(int poids) {
  if (poids <= 10) return poids * 4;
  if (poids <= 20) return 40 + (poids - 10) * 2;
  return 60 + (poids - 20);
}

enum Chirurgie {
  mineure('mineure', 2, 2),
  intermediaire('intermédiaire', 4, 6),
  majeure('majeure', 6, 10);

  const Chirurgie(this.libelle, this.minimum, this.maximum);
  final String libelle;
  final int minimum;
  final int maximum;

  String get taux =>
      minimum == maximum ? '$minimum ml/kg/h' : '$minimum à $maximum ml/kg/h';
}

({double minimum, double maximum}) calculerPertesChirurgicales(
        num poids, Chirurgie chirurgie) =>
    (
      minimum: poids * chirurgie.minimum.toDouble(),
      maximum: poids * chirurgie.maximum.toDouble(),
    );

// Bornes sans chevauchement : nouveau-né <1 mois, puis <12, <24,
// <60, <=144 mois. À 2 et 5 ans, entrée dans la tranche suivante.
Map<String, String> obtenirConstantesPhysiologiques(int ageEnMois) {
  final Map<String, String> valeurs;
  if (ageEnMois < 1) {
    valeurs = {'FC': '140 - 180', 'PAS': '60 / 35', 'FR': '30 - 60'};
  } else if (ageEnMois < 12) {
    valeurs = {'FC': '120 - 150', 'PAS': '90 / 65', 'FR': '24 - 40'};
  } else if (ageEnMois < 24) {
    valeurs = {'FC': '110 - 130', 'PAS': '95 / 65', 'FR': '20 - 30'};
  } else if (ageEnMois < 60) {
    valeurs = {'FC': '105 - 120', 'PAS': '100 / 60', 'FR': '20 - 30'};
  } else if (ageEnMois <= 144) {
    valeurs = {'FC': '90 - 110', 'PAS': '110 / 60', 'FR': '16 - 20'};
  } else {
    valeurs = {'FC': '70 - 100', 'PAS': '120 / 65', 'FR': '16 - 20'};
  }
  if (ageEnMois < 1) {
    valeurs['Hypotension'] = 'si PAM < âge gestationnel à la naissance (SA)';
  } else {
    final seuil = calculerSeuilHypotension(ageEnMois);
    if (seuil != null) {
      valeurs['Hypotension'] = 'si PAS < ${formaterNombre(seuil)} mmHg';
    }
  }
  return valeurs;
}

Map<String, String> obtenirTailleguedel(int ageEnMois) {
  if (ageEnMois < 1) {
    return {'tailleguedel': '000 ou 00 (transparente / bleue)'};
  }
  if (ageEnMois < 12) return {'tailleguedel': '0 (grise)'};
  if (ageEnMois < 60) return {'tailleguedel': '1 (blanche)'};
  return {'tailleguedel': '2 ou 3 (verte / orange)'};
}

Map<String, String> obtenirCircuit(int poids) {
  if (poids < 5) return {'circuit': 'Neonat'};
  if (poids < 25) return {'circuit': 'pediatrique'};
  return {'circuit': 'adulte'};
}
