import 'package:flutter/material.dart';
import 'package:pedianesth/divers.dart';
import 'package:pedianesth/english/homeenglish.dart';
import 'package:pedianesth/english/posologieenglish.dart';
import 'package:pedianesth/fiches.dart';

//import 'package:pedianesth/poids.dart';

class Mainen extends StatefulWidget {
  const Mainen({super.key});

  @override
  State<Mainen> createState() => _MainAppState();
}

class _MainAppState extends State<Mainen> {
  int currentIndex = 0;
  final screens = [
    const Homeenglish(),
    const PosologieEnglishScreen(),
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
