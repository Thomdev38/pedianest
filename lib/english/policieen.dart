import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class Policieen extends StatefulWidget {
  const Policieen({super.key});

  @override
  State<Policieen> createState() => _PolicieenState();
}

class _PolicieenState extends State<Policieen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Politique de confidentialité"),
      ),
      body: PdfViewer.asset("assets/pdf/politiqueconfidentialite.pdf"),
    );
  }
}
