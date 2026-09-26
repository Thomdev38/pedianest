import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pedianesth/main.dart';
import 'package:pedianesth/memo_pediatrique.dart';

Future<void> saisir(WidgetTester tester, String age, String poids,
    {bool enMois = false}) async {
  await tester.enterText(find.byType(TextField).at(0), age);
  await tester.enterText(find.byType(TextField).at(1), poids);
  if (enMois) {
    await tester.tap(find.byType(SwitchListTile).first);
    await tester.pumpAndSettle();
  }
  await tester.ensureVisible(find.text('Calculer'));
  await tester.tap(find.text('Calculer'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Fluidothérapie et morphines conservées sur écran de 360 px',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MainApp());
    await saisir(tester, '5', '20');
    expect(find.text('Oramorph: 4.0 mg'), findsOneWidget);
    expect(find.text('Actiskenan: 20 mg'), findsOneWidget);
    expect(find.text('Skenan lp: 20 mg'), findsOneWidget);
    expect(find.text('Taille Lame: 2'), findsOneWidget);
    expect(find.text('Taille Guedel: 2 ou 3 (verte / orange)'), findsOneWidget);
    expect(find.textContaining('cristalloïde isotoniquement équilibré'),
        findsOneWidget);
    await tester.ensureVisible(find.text('Quel solute pour quel enfant ?'));
    await tester.tap(find.text('Quel solute pour quel enfant ?'));
    await tester.pumpAndSettle();
    expect(find.text('Isopédia'), findsOneWidget);
    expect(find.text('RL possible apres 4 ans'), findsOneWidget);
    await tester.ensureVisible(find.text('Apport Liquidien de base: 60 ml/h'));
    await tester.tap(find.text('Apport Liquidien de base: 60 ml/h'));
    await tester.pumpAndSettle();
    expect(find.textContaining('règle 4-2-1'), findsOneWidget);
    expect(find.textContaining('Duree du jeune'), findsNothing);
    expect(find.textContaining('50%'), findsNothing);
    await tester.ensureVisible(find.byType(TextField).first);
    await saisir(tester, '5', '10');
    expect(find.text('Pour 10 kg : 20 ml/h'), findsOneWidget);
    expect(find.text('Pour 20 kg : 40 ml/h'), findsNothing);
    expect(
        find.text(
            'Morphine IV postopératoire — dose de charge: 1.0 mg IV lente'),
        findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  for (final cas in [
    ('2', false, '74'),
    ('24', true, '74'),
    ('5', false, '80'),
    ('60', true, '80'),
    ('10', false, '90')
  ]) {
    testWidgets('Calcul réel pour ${cas.$1} ${cas.$2 ? "mois" : "ans"}',
        (tester) async {
      await tester.pumpWidget(const MainApp());
      await saisir(tester, cas.$1, '20', enMois: cas.$2);
      expect(find.text('Hypotension: si PAS < ${cas.$3} mmHg'), findsOneWidget);
      expect(find.text('Apport Liquidien de base: 60 ml/h'), findsOneWidget);
      expect(find.text('Pour 20 kg : 40 ml/h'), findsOneWidget);
      expect(find.text('Pour 20 kg : 80 à 120 ml/h'), findsOneWidget);
      expect(find.text('Pour 20 kg : 120 à 200 ml/h'), findsOneWidget);
      expect(
          find.text(
              'Morphine IV postopératoire — dose de charge: 2.0 mg IV lente'),
          findsOneWidget);
      expect(
          find.text(
              'Morphine — bolus de titration après la charge: 500 à 1000 µg par bolus'),
          findsOneWidget);
      expect(
          find.textContaining(
              '25 à 50 µg/kg. Réévaluation toutes les 5 minutes'),
          findsOneWidget);
      expect(find.textContaining('compensation systématique d’un déficit'),
          findsOneWidget);
      expect(find.textContaining('50%'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('La règle PAM néonatale disparaît après le premier mois',
      (tester) async {
    await tester.pumpWidget(const MainApp());
    await saisir(tester, '0', '3', enMois: true);
    expect(find.textContaining('Hypotension: si PAM'), findsOneWidget);
    await tester.ensureVisible(find.byType(TextField).first);
    await saisir(tester, '6', '6');
    expect(find.textContaining('Hypotension:'), findsNothing);
    expect(find.text('PAS - PAD: 90 / 65'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Mémo replié par défaut et lisible sur petit écran',
      (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: SingleChildScrollView(child: MemoPediatrique())),
    ));
    expect(find.text('Guedel'), findsNothing);
    await tester.tap(find.text('Repères pédiatriques'));
    await tester.pumpAndSettle();
    expect(find.text('Guedel'), findsOneWidget);
    expect(find.text('Lame de laryngoscope'), findsOneWidget);
    expect(find.text('Masque facial'), findsOneWidget);
    expect(find.textContaining('Droite 1 ou courbe 0'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.textContaining('Référence :'), findsNothing);
    expect(find.textContaining('Pierre pratique'), findsNothing);
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Repères pédiatriques'));
    await tester.pumpAndSettle();
    expect(find.text('Guedel'), findsNothing);
  });
}
