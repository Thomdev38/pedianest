import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

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
      body: PdfViewer.asset("assets/pdf/laryngospasmepediatrie.pdf"),
    );
  }
}
