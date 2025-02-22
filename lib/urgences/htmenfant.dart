import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

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
      body: PdfViewer.asset("assets/pdf/HyperthermieMaligneenfant.pdf"),
    );
  }
}
