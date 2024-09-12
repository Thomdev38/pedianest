import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:pedianesth/french/posologiecalculator.dart';

class Homefrench extends StatefulWidget {
  const Homefrench({super.key});

  @override
  State<Homefrench> createState() => _HomefrenchState();
}

class _HomefrenchState extends State<Homefrench> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
      child: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: "Accédez à l'outils",
        onFinish: () {
          Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => const PosologieCalculatorScreen()),
          );
        },
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Color.fromARGB(225, 86, 125, 199),
        ),
        background: [
          Image.asset('assets/images/slide_1.jpeg'),
          Image.asset('assets/images/slide_2.jpeg'),
          Image.asset('assets/images/slide_1.jpeg'),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          const Column(
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text("entrez caracteristique patient"),
            ],
          ),
          const Column(
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text('preparer salle'),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('anesthésie'),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
