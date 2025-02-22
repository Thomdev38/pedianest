import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class Acrenfant extends StatefulWidget {
  const Acrenfant({super.key});

  @override
  State<Acrenfant> createState() => _AcrenfantState();
}

class _AcrenfantState extends State<Acrenfant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ACR Enfant"),
      ),
      body: PdfViewer.asset("assets/pdf/ACR-au-bloc-chez-l-enfant.pdf"),
    );
  }
}
