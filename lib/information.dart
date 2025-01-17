import 'package:flutter/material.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Information"),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Text(
                    "Vous pouvez souscrire si vous trouvez l'application interessante en cliquant sur le lien suivant "),
                const SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  backgroundColor: Colors.black12,
                  radius: 150,
                  child: Image.asset("assets/images/ours.jpg"),
                )
              ],
            )));
  }
}
