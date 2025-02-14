import 'package:flutter/material.dart';
import 'package:pedianesth/divers.dart';
import 'package:pedianesth/fiches.dart';
import 'package:pedianesth/homepage.dart';
// ignore: unused_import

//import 'package:pedianesth/poids.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 0;
  final screens = [
    const PosologieCalculatorScreen(),
    const Fiches(),
    Divers(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(225, 86, 125, 199),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            iconSize: 30,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.medication_liquid),
                label: "Poids",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assessment_outlined),
                label: "Fiches réflexes",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Divers",
              ),
            ],
          )),
    );
  }
}
