import 'package:flutter/material.dart';

class Sources extends StatefulWidget {
  const Sources({super.key});

  @override
  State<Sources> createState() => _SourcesState();
}

class _SourcesState extends State<Sources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sources"),
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
