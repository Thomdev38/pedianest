import 'package:flutter/material.dart';
import 'package:pedianesth/main.dart';
import 'package:pedianesth/responsive.dart';
import 'package:pedianesth/urgences/acrenfant.dart';
import 'package:pedianesth/urgences/anaphylaxienfant.dart';
import 'package:pedianesth/urgences/htmenfant.dart';
import 'package:pedianesth/urgences/intoxalenfant.dart';
import 'package:pedianesth/urgences/iotdiffenfant.dart';
import 'package:pedianesth/urgences/laryngospasme.dart';
import 'package:pedianesth/urgences/reanne.dart';

class Fiches extends StatefulWidget {
  const Fiches({super.key});

  @override
  State<Fiches> createState() => _FichesState();
}

class _FichesState extends State<Fiches> {
  final List<Map<String, dynamic>> items = [
    {"title": "ACR", "icon": Icons.monitor_heart, "color": AppColors.pastelRed},
    {"title": "Anaphylaxie", "icon": Icons.warning_amber_rounded, "color": AppColors.pastelOrange},
    {"title": "Hyperthermie maligne", "icon": Icons.thermostat, "color": AppColors.pastelPink},
    {"title": "Intoxication Anesthesique locaux", "icon": Icons.science_outlined, "color": AppColors.pastelPurple},
    {"title": "Intubation difficile", "icon": Icons.air, "color": AppColors.primaryBlue},
    {"title": "Laryngospasme", "icon": Icons.emergency, "color": AppColors.accentTeal},
    {"title": "Rea du nouveau nee", "icon": Icons.child_care, "color": AppColors.pastelGreen},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fiches reflexe"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ResponsiveCenter(
          maxWidth: 900,
          child: ResponsiveMasonry(
            children: [
              for (final item in items) _buildCard(context, item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          String selectedItem = item["title"];
          Widget pageToNavigate;

          switch (selectedItem) {
            case "ACR":
              pageToNavigate = const Acrenfant();
              break;
            case "Anaphylaxie":
              pageToNavigate = const Anaphylaxieenfant();
              break;
            case "Hyperthermie maligne":
              pageToNavigate = const Htmenfant();
              break;
            case "Intoxication Anesthesique locaux":
              pageToNavigate = const Intoxalenfant();
              break;
            case "Intubation difficile":
              pageToNavigate = const Iotdiffenfant();
              break;
            case "Laryngospasme":
              pageToNavigate = const Laryngospasme();
              break;
            case "Rea du nouveau nee":
              pageToNavigate = const Reanne();
              break;
            default:
              pageToNavigate = const Acrenfant();
          }

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pageToNavigate),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(color: item["color"], width: 4),
            ),
            boxShadow: [
              BoxShadow(
                color: (item["color"] as Color).withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: (item["color"] as Color).withValues(alpha: 0.15),
              child: Icon(item["icon"], color: item["color"], size: 22),
            ),
            title: Text(
              item["title"],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                fontSize: 15,
              ),
            ),
            trailing: Icon(Icons.chevron_right, color: item["color"]),
          ),
        ),
      ),
    );
  }
}
