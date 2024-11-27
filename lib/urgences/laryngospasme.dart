import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Laryngospasme extends StatefulWidget {
  const Laryngospasme({super.key});

  @override
  State<Laryngospasme> createState() => _LaryngospasmeState();
}

class _LaryngospasmeState extends State<Laryngospasme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Laryngospasme"),
        ),
        body: SfPdfViewer.asset("assets/pdf/laryngospasmepediatrie.pdf"),
        );
  }
}