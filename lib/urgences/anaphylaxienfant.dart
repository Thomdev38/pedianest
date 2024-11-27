  
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Anaphylaxieenfant extends StatefulWidget {
  const Anaphylaxieenfant({super.key});

  @override
  State<Anaphylaxieenfant> createState() => _AnaphylaxieenfantState();
}

class _AnaphylaxieenfantState extends State<Anaphylaxieenfant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Anaphylaxie enfant"),
        ),
        body: SfPdfViewer.asset("assets/pdf/anaphylaxie-pediatrie.pdf"),
        );
  }
}