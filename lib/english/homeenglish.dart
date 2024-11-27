import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:pedianesth/french/posologiecalculator.dart';

class Homeenglish extends StatefulWidget {
  const Homeenglish({super.key});

  @override
  State<Homeenglish> createState() => _HomeenglishState();
}

class _HomeenglishState extends State<Homeenglish> {
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
              Text("entrer caracteristic patient"),
            ],
          ),
          const Column(
            children: <Widget>[
              SizedBox(
                height: 480,
              ),
              Text('prepar operating room'),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('netflix'),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
