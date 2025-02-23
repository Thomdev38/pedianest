import 'package:flutter/material.dart';

import 'package:pedianesth/english/diversen.dart';
import 'package:pedianesth/english/homeen.dart';
import 'package:pedianesth/fiches.dart';

// ignore: unused_import

//import 'package:pedianesth/poids.dart';

void main() {
  runApp(const MainenApp());
}

class MainenApp extends StatefulWidget {
  const MainenApp({super.key});

  @override
  State<MainenApp> createState() => _MainenAppState();
}

class _MainenAppState extends State<MainenApp> {
  int currentIndex = 0;
  final screens = [
    const PosologieCalculatorenScreen(),
    const Fiches(),
    const Diversen(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(224, 182, 94, 218),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            iconSize: 30,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.medication_liquid),
                label: "Weight",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assessment_outlined),
                label: "Fiches réflexes",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Other",
              ),
            ],
          )),
    );
  }
}
