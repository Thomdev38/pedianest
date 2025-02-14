import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Policie extends StatefulWidget {
  const Policie({super.key});

  @override
  State<Policie> createState() => _PolicieState();
}

class _PolicieState extends State<Policie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Politique de confidentialité"),
      ),
      body: SfPdfViewer.asset("assets/pdf/politiqueconfidentialite.pdf"),
    );
  }
}
