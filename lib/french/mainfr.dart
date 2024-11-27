import 'package:flutter/material.dart';
import 'package:pedianesth/french/divers.dart';
import 'package:pedianesth/french/fiches.dart';
import 'package:pedianesth/french/homepagefr.dart';

//import 'package:pedianesth/poids.dart';
import 'package:pedianesth/french/posologiecalculator.dart';

class Mainfr extends StatefulWidget {
  const Mainfr({super.key});

  @override
  State<Mainfr> createState() => _MainfrState();
}

class _MainfrState extends State<Mainfr> {
  int currentIndex = 0;
  final screens = [
    const Homefrench(),
    const PosologieCalculatorScreen(),
    const Fiches(),
    const Divers(),
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
                icon: Icon(Icons.home),
                label: "Home",
              ),
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
