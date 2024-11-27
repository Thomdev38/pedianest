
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Htmenfant extends StatefulWidget {
  const Htmenfant({super.key});

  @override
  State<Htmenfant> createState() => _HtmenfantState();
}

class _HtmenfantState extends State<Htmenfant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Hyperthermie maligne enfant"),
        ),
        body: SfPdfViewer.asset("assets/pdf/HyperthermieMaligneenfant.pdf"),
        );
  }
}