import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class Iotdiffenfant extends StatefulWidget {
  const Iotdiffenfant({super.key});

  @override
  State<Iotdiffenfant> createState() => _IotdiffenfantState();
}

class _IotdiffenfantState extends State<Iotdiffenfant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("IOT difficile chez l'enfant"),
      ),
      body: PdfViewer.asset("assets/pdf/iot-difficile-chez-l-enfant.pdf"),
    );
  }
}
