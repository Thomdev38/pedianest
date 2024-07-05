
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Intoxalenfant extends StatefulWidget {
  const Intoxalenfant ({super.key});

  @override
  State<Intoxalenfant > createState() => _IntoxalenfantState();
}

class _IntoxalenfantState extends State<Intoxalenfant > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Intoxication anesthésique locaux enfant"),
        ),
        body: SfPdfViewer.asset("assets/pdf/intoxication-Anesthesiques-Locaux-enfant.pdf"),
        );
  }
}