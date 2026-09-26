import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pedianesth/main.dart';
import 'package:pedianesth/posologies_fr.dart';
import 'widget_test.dart' show saisir;

void main() {
  for (final cas in [
    ('nouveau-né', '0', true, '3', '6 mg IV', true),
    ('6 mois', '6', true, '7', '14 mg IV', true),
    ('11 mois', '11', true, '9', '18 mg IV', true),
    ('12 mois', '12', true, '11', '11 à 16,5 mg IV', false),
    ('2 ans', '2', false, '13', '13 à 19,5 mg IV', false),
    ('10 ans', '10', false, '30', '30 à 45 mg IV', false),
  ]) {
    testWidgets('Succinylcholine IV pour intubation : ${cas.$1}',
        (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(360, 800);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MainApp());
      await saisir(tester, cas.$2, cas.$4, enMois: cas.$3);
      expect(
          find.text('Célocurine / succinylcholine — intubation IV: ${cas.$5}'),
          findsOneWidget);
      expect(
          find.text(cas.$6
              ? 'Âge <12 mois : 2 mg/kg IV pour intubation.'
              : 'Âge ≥12 mois : 1 à 1,5 mg/kg IV pour intubation.'),
          findsOneWidget);
      expect(find.textContaining('Celocurine:'), findsNothing);
      expect(find.textContaining('mg/kg IM'), findsNothing);
      expect(find.text('Doses Induction'), findsNothing);
      expect(find.text('Rémifentanil — perfusion IV'), findsOneWidget);
      expect(find.text('0,2 à 0,5 µg/kg/min — adapter à la réponse clinique.'),
          findsOneWidget);
      expect(find.text('0,2 à 0,5 µg/kg'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
  for (final cas in [(5, 2.5, 10), (20, 10.0, 40), (31, 15.5, 62)]) {
    test('Phényléphrine ${cas.$1} kg, résultats en µg', () {
      final dose = calculerPhenylephrineMicrogrammes(cas.$1);
      expect(dose.minimum, cas.$2);
      expect(dose.maximum, cas.$3);
    });
  }
  for (final cas in [(5, 0.15, 0.30), (20, 0.60, 1.20), (30, 0.90, 1.80)]) {
    test('Fibrinogène ${cas.$1} kg, bornes ordonnées en g', () {
      final dose = calculerFibrinogeneGrammes(cas.$1);
      expect(dose.minimum, closeTo(cas.$2, 1e-10));
      expect(dose.maximum, closeTo(cas.$3, 1e-10));
      expect(dose.minimum, lessThan(dose.maximum));
    });
  }
  for (final cas in [(5, 0.1, 0.8), (6, 0.2, 1.6), (7, 0.2, 1.6)]) {
    test('Nalbuphine ${cas.$1} mois, 8 kg', () {
      expect(tauxNalbuphineMgKg(cas.$1), cas.$2);
      expect(calculerNalbuphineMg(8, cas.$1), closeTo(cas.$3, 1e-10));
    });
    testWidgets('Nalbuphine : saisie en mois et aide à ${cas.$1} mois',
        (tester) async {
      await tester.pumpWidget(const MainApp());
      await saisir(tester, '${cas.$1}', '8', enMois: true);
      expect(find.text('Nalbuphine: ${cas.$3} mg'), findsOneWidget);
      expect(
          find.text(cas.$1 < 6
              ? '0,1 mg/kg (âge <6 mois)'
              : '0,2 mg/kg (âge ≥6 mois)'),
          findsOneWidget);
      expect(find.textContaining('divise par deux'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
  for (final cas in [
    (5, 50.0, 50.0),
    (20, 200.0, 200.0),
    (29, 290.0, 290.0),
    (30, 1000.0, null),
    (31, 1000.0, null),
  ]) {
    test('Exacyl ${cas.$1} kg : charge et entretien distincts', () {
      final dose = calculerExacyl(cas.$1);
      expect(dose.chargeMg, cas.$2);
      expect(dose.entretienMgH, cas.$3);
    });
  }
  for (final cas in [
    (5, '2.5 - 10', '1.0 - 2.5', '0.15 - 0.30', '50 mg', '50 mg/h'),
    (20, '10.0 - 40', '4.0 - 10.0', '0.60 - 1.20', '200 mg', '200 mg/h'),
    (29, '14.5 - 58', '5.8 - 14.5', '0.87 - 1.74', '290 mg', '290 mg/h'),
    (30, '15.0 - 60', '6.0 - 15.0', '0.90 - 1.80', '1 g', null),
    (31, '15.5 - 62', '6.2 - 15.5', '0.93 - 1.86', '1 g', null),
  ]) {
    testWidgets('Parcours anesthésie → urgences à ${cas.$1} kg',
        (tester) async {
      await tester.pumpWidget(const MainApp());
      await saisir(tester, '2', '${cas.$1}');
      expect(find.text('Néosynéphrine / phényléphrine: ${cas.$2} µg'),
          findsOneWidget);
      expect(find.text('Bolus : 0,5 à 2 µg/kg ; maximum : 10 µg/kg'),
          findsOneWidget);
      expect(find.text('Rémifentanil — perfusion IV'), findsOneWidget);
      expect(find.text('Débit: ${cas.$3} µg/min'), findsOneWidget);
      expect(find.textContaining('Remifentanyl:'), findsNothing);
      expect(find.text('0,2 à 0,5 µg/kg/min — adapter à la réponse clinique.'),
          findsOneWidget);
      expect(find.text('0,2 à 0,5 µg/kg'), findsNothing);
      expect(find.text('Nalbuphine: ${(cas.$1 * 0.2).toStringAsFixed(1)} mg'),
          findsOneWidget);
      // Valeurs hors périmètre : vérifier qu'elles n'ont pas été modifiées.
      expect(find.text('Fentanyl: ${cas.$1 * 20} - ${cas.$1 * 50} mcg'),
          findsOneWidget);
      expect(find.text('Actiskenan: ${cas.$1} mg'), findsOneWidget);
      expect(find.text('Skenan lp: ${cas.$1} mg'), findsOneWidget);
      await tester.tap(find.widgetWithText(Tab, 'Urgences'));
      await tester.pumpAndSettle();
      expect(find.text('Blood management'), findsOneWidget);
      expect(find.text('Fibrinogene: ${cas.$4} g'), findsOneWidget);
      expect(find.textContaining('Administration non systématique'),
          findsOneWidget);
      expect(find.text('Exacyl — dose de charge / bolus: ${cas.$5}'),
          findsOneWidget);
      if (cas.$6 != null) {
        expect(find.text('Exacyl — entretien après la charge: ${cas.$6}'),
            findsOneWidget);
      } else {
        expect(find.textContaining('Exacyl — entretien'), findsNothing);
        expect(find.textContaining('10 mg/kg/h au PSE'), findsNothing);
      }
      expect(tester.takeException(), isNull);
    });
  }
}
