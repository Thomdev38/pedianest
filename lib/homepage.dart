import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:pedianesth/posologiecalculator.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: 'Commencez',
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
        skipTextButton: const Text('Passer'),
        background: [
          Image.asset('assets/images/slide_1.jpeg'),
          Image.asset('assets/images/slide_2.jpeg'),
          Image.asset('assets/images/slide_1.jpeg'),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text("Rentrez les informations de l'enfant"),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Préparez votre salle'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                Text('Gérer votre anesthésie'),
              ],
            ),
          ),
        ],
      ),
    );
    
  }
}
