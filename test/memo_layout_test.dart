import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pedianesth/memo_pediatrique.dart';

void main() {
  for (final cas in [(360.0, 1.0), (1080.0, 1.0), (360.0, 1.8)]) {
    testWidgets('Mémo ${cas.$1} px, texte ×${cas.$2}', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = Size(cas.$1, 900);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(cas.$2),
          ),
          child: child!,
        ),
        home: const Scaffold(
          body: SingleChildScrollView(child: MemoPediatrique()),
        ),
      ));
      expect(find.text('Ventilation'), findsNothing);
      await tester.tap(find.text('Repères pédiatriques'));
      await tester.pumpAndSettle();
      final ventilation =
          tester.getRect(find.byKey(const ValueKey('repere-Ventilation')));
      final guedel =
          tester.getRect(find.byKey(const ValueKey('repere-Guedel')));
      if (cas.$1 < 680) {
        expect(guedel.left, ventilation.left);
        expect(guedel.top, greaterThan(ventilation.bottom));
      } else {
        expect(guedel.top, ventilation.top);
        expect(guedel.left, greaterThan(ventilation.right));
      }
      for (final titre in [
        'Ventilation',
        'Guedel',
        'Lame de laryngoscope',
        'Masque facial',
        'Hémodynamique'
      ]) {
        final card = find.byKey(ValueKey('repere-$titre'));
        final rect = tester.getRect(card);
        expect(rect.left, greaterThanOrEqualTo(0));
        expect(rect.right, lessThanOrEqualTo(cas.$1));
        await tester.ensureVisible(card);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
      expect(find.textContaining('Référence :'), findsNothing);
      expect(find.textContaining('Pierre pratique'), findsNothing);
    });
  }
}
