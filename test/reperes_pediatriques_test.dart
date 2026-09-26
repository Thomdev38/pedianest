import 'package:flutter_test/flutter_test.dart';
import 'package:pedianesth/reperes_pediatriques.dart';

void main() {
  group('Apports de base 4-2-1', () {
    for (final cas in {0: 0, 5: 20, 10: 40, 15: 50, 20: 60, 25: 65}.entries) {
      test('${cas.key} kg = ${cas.value} ml/h', () {
        expect(calculerApportLiquidien(cas.key), cas.value);
      });
    }
  });
  group('Hypotension et conversion de la saisie', () {
    for (final cas in [
      (2, false, 74),
      (5, false, 80),
      (10, false, 90),
      (24, true, 74),
      (60, true, 80),
      (18, true, 73)
    ]) {
      test('${cas.$1} ${cas.$2 ? "mois" : "ans"}', () {
        final mois = convertirAgeEnMois(cas.$1, enMois: cas.$2);
        expect(calculerSeuilHypotension(mois), cas.$3);
        expect(obtenirConstantesPhysiologiques(mois)['Hypotension'],
            'si PAS < ${cas.$3} mmHg');
      });
    }
    test('Formule strictement après 1 an, sans arrondi de l’âge', () {
      for (final mois in [0, 1, 6, 11, 12]) {
        expect(calculerSeuilHypotension(mois), isNull);
      }
      expect(calculerSeuilHypotension(13), closeTo(72.1666667, 0.000001));
    });
  });
  group('Constantes physiologiques et limites des tranches', () {
    for (final cas in [
      (0, '140 - 180', '60 / 35', '30 - 60'),
      (1, '120 - 150', '90 / 65', '24 - 40'),
      (6, '120 - 150', '90 / 65', '24 - 40'),
      (11, '120 - 150', '90 / 65', '24 - 40'),
      (12, '110 - 130', '95 / 65', '20 - 30'),
      (18, '110 - 130', '95 / 65', '20 - 30'),
      (23, '110 - 130', '95 / 65', '20 - 30'),
      (24, '105 - 120', '100 / 60', '20 - 30'),
      (48, '105 - 120', '100 / 60', '20 - 30'),
      (59, '105 - 120', '100 / 60', '20 - 30'),
      (60, '90 - 110', '110 / 60', '16 - 20'),
      (96, '90 - 110', '110 / 60', '16 - 20'),
      (144, '90 - 110', '110 / 60', '16 - 20'),
      (145, '70 - 100', '120 / 65', '16 - 20'),
      (156, '70 - 100', '120 / 65', '16 - 20'),
    ]) {
      test('${cas.$1} mois', () {
        final valeurs = obtenirConstantesPhysiologiques(cas.$1);
        expect(valeurs['FC'], cas.$2);
        expect(valeurs['PAS'], cas.$3);
        expect(valeurs['FR'], cas.$4);
        expect(valeurs['Hypotension']?.contains('gestationnel') ?? false,
            cas.$1 == 0);
      });
    }
  });
  group('Pertes chirurgicales estimées', () {
    for (final cas in [
      (5, Chirurgie.mineure, 10, 10),
      (5, Chirurgie.intermediaire, 20, 30),
      (5, Chirurgie.majeure, 30, 50),
      (20, Chirurgie.mineure, 40, 40),
      (20, Chirurgie.intermediaire, 80, 120),
      (20, Chirurgie.majeure, 120, 200),
      (25, Chirurgie.mineure, 50, 50),
      (25, Chirurgie.intermediaire, 100, 150),
      (25, Chirurgie.majeure, 150, 250),
    ]) {
      test('${cas.$1} kg / ${cas.$2.libelle}', () {
        final pertes = calculerPertesChirurgicales(cas.$1, cas.$2);
        expect(pertes.minimum, cas.$3);
        expect(pertes.maximum, cas.$4);
      });
    }
  });
  group('Guedel aux limites des tranches', () {
    for (final cas in {
      0: '000 ou 00 (transparente / bleue)',
      1: '0 (grise)',
      11: '0 (grise)',
      12: '1 (blanche)',
      24: '1 (blanche)',
      59: '1 (blanche)',
      60: '2 ou 3 (verte / orange)',
      61: '2 ou 3 (verte / orange)',
      144: '2 ou 3 (verte / orange)',
      145: '2 ou 3 (verte / orange)',
    }.entries) {
      test('${cas.key} mois', () {
        expect(obtenirTailleguedel(cas.key)['tailleguedel'], cas.value);
      });
    }
  });
  test('Circuit : seuils stricts de 5 et 25 kg', () {
    expect(obtenirCircuit(4)['circuit'], 'Neonat');
    expect(obtenirCircuit(5)['circuit'], 'pediatrique');
    expect(obtenirCircuit(24)['circuit'], 'pediatrique');
    expect(obtenirCircuit(25)['circuit'], 'adulte');
  });
}
