import "package:flutter/material.dart";
import 'package:pedianesth/main.dart';

class AntibioPage extends StatelessWidget {
  final double? dosePropofolEntretien;
  final int? poidstext;
  final int? doseLidocaine;
  final int? doseRopivacaine;
  final double? doseBupivacaine;
  final int? dosePrilocaine;
  final int? age;
  final int? isAgeInMonths;
  final int? doseCefazoline;
  final int? doseAmox;
  final int? doseCefoxitine;
  final int? doseClindamycine;
  final int? doseGentamycine;
  final int? doseMetronidazole;
  final int? doseVancomycinemini;
  final int? doseVancomycinemaxi;

  const AntibioPage({
    super.key,
    this.dosePropofolEntretien,
    this.poidstext,
    this.doseLidocaine,
    this.doseBupivacaine,
    this.doseRopivacaine,
    this.dosePrilocaine,
    this.isAgeInMonths,
    this.age,
    this.doseCefazoline,
    this.doseCefoxitine,
    this.doseAmox,
    this.doseClindamycine,
    this.doseGentamycine,
    this.doseMetronidazole,
    this.doseVancomycinemini,
    this.doseVancomycinemaxi,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          if (dosePropofolEntretien == null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.pastelOrange.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.pastelOrange.withValues(alpha: 0.6)),
              ),
              child: const Text(
                "Veuillez rentrer le poids et l'age de l'enfant pour obtenir les doses d'antibiotiques et d'anesthesiques locaux",
                style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset("assets/images/ours.jpg"),
            ),
          ],
          if (doseLidocaine != null) ...[
            if (dosePropofolEntretien != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Pour un enfant de ${poidstext!} kg voici les doses d'antibio-prophylaxie recommandees et d'anesthesiques locaux",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark),
                ),
              ),
            const SizedBox(height: 12),

            // Anesthesiques locaux
            _AntibioSection(
              title: 'Anesthesiques locaux',
              borderColor: AppColors.textMuted,
              icon: Icons.local_hospital_outlined,
              children: [
                _AntibioDoseRow(name: 'Lidocaine', dose: '$doseLidocaine mg/6h', hint: '5 mg/kg/6h'),
                _AntibioDoseRow(name: 'Bupivacaine', dose: '$doseBupivacaine mg/6h', hint: '2,5 mg/kg/6h'),
                _AntibioDoseRow(name: 'Ropivacaine', dose: '$doseRopivacaine mg/6h', hint: '3 mg/kg/6h'),
                _AntibioDoseRow(name: 'Prilocaine', dose: '$dosePrilocaine mg/6h', hint: '5 mg/kg/6h'),
                const _AntibioDoseRow(
                  name: 'Xylocaine Spray 5%',
                  dose: '1 pulverisation / 10 kg de poids',
                  hint: '1 pulverisation = 8mg',
                ),
              ],
            ),

            // Antibioprophylaxie
            _AntibioSection(
              title: 'Antibioprophylaxie',
              borderColor: AppColors.pastelGreen,
              icon: Icons.medication_outlined,
              children: [
                _AntibioDoseRow(name: 'Cefazoline', dose: '$doseCefazoline mg', hint: '30 mg/kg, si duree > 4h refaire la meme dose'),
                _AntibioDoseRow(name: 'Amoxicilline/acide clavulanique', dose: '$doseAmox mg', hint: '50 mg/kg (max 2g), si duree > 2h refaire la meme dose (max 1g)'),
                _AntibioDoseRow(name: 'Clindamycine', dose: '$doseClindamycine mg', hint: '10 mg/kg (max 900mg), si duree > 4h refaire la meme dose (max 450mg a 600mg suivant les indications)'),
                _AntibioDoseRow(name: 'Gentamicyne', dose: '$doseGentamycine mg', hint: '6 mg/kg dose unique'),
                _AntibioDoseRow(name: 'Cefoxitine', dose: '$doseCefoxitine mg', hint: '40 mg/kg (max 2g), si duree > 2h refaire meme dose (max 1g)'),
                _AntibioDoseRow(name: 'Metronidazole', dose: '$doseMetronidazole mg', hint: '15 mg/kg, dose unique'),
                _AntibioDoseRow(name: 'Vancomycine', dose: '$doseVancomycinemini a $doseVancomycinemaxi mg', hint: '20 a 30 mg/kg en 60 minutes, dose unique'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _AntibioSection extends StatelessWidget {
  final String title;
  final Color borderColor;
  final IconData? icon;
  final List<Widget> children;

  const _AntibioSection({
    required this.title,
    required this.borderColor,
    this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: borderColor, width: 4)),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: borderColor, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: borderColor.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _AntibioDoseRow extends StatelessWidget {
  final String name;
  final String dose;
  final String? hint;

  const _AntibioDoseRow({required this.name, required this.dose, this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name: $dose',
            style: const TextStyle(fontSize: 15, color: AppColors.textDark),
          ),
          if (hint != null)
            Text(hint!, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
