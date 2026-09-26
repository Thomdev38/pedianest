// Règles de la deuxième passe française, selon le référentiel fourni.
// Les unités font partie des noms pour éviter toute conversion implicite.
({double minimum, int maximum}) calculerPhenylephrineMicrogrammes(int poids) =>
    (minimum: poids * 0.5, maximum: poids * 2);

({double minimum, double maximum}) calculerFibrinogeneGrammes(int poids) =>
    (minimum: poids * 0.03, maximum: poids * 0.06);

double tauxNalbuphineMgKg(int ageEnMois) => ageEnMois < 6 ? 0.1 : 0.2;

double calculerNalbuphineMg(int poids, int ageEnMois) =>
    poids * tauxNalbuphineMgKg(ageEnMois);

/// Contexte hémorragique : charge et, sous 30 kg, débit d'entretien distinct.
/// Aucun débit n'est proposé à partir de 30 kg dans le référentiel demandé.
({double chargeMg, double? entretienMgH}) calculerExacyl(int poids) =>
    poids < 30
        ? (chargeMg: poids * 10.0, entretienMgH: poids * 10.0)
        : (chargeMg: 1000.0, entretienMgH: null);

/// Intubation IV : règle demandée, âge chronologique en mois.
({double minimum, double maximum}) calculerSuccinylcholineIVMg(
        int poids, int ageEnMois) =>
    ageEnMois < 12
        ? (minimum: poids * 2.0, maximum: poids * 2.0)
        : (minimum: poids * 1.0, maximum: poids * 1.5);
