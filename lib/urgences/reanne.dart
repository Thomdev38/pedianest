
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Reanne extends StatefulWidget {
  const Reanne({super.key});

  @override
  State<Reanne> createState() => _ReanneState();
}

class _ReanneState extends State<Reanne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Réanimation du nouveau né en salle de naissance"),
        ),
        body: SfPdfViewer.asset("assets/pdf/reanimation-du-nouveau-ne-en-salle-de-naissance.pdf"),
        );
  }
}