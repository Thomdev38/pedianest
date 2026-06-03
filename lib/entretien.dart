import "package:flutter/material.dart";
import 'package:pedianesth/main.dart';

class UrgencePage extends StatelessWidget {
  final double? dosePropofolEntretien;
  final int? poidstext;
  final int? agemoistext;
  final int? dosemaxPFC;
  final int? doseminPFC;
  final int? dosemaxPqt;
  final int? doseminPqt;
  final double? doseGluconateCamin;
  final double? doseGluconateCamax;
  final double? dosemaxFibri;
  final double? doseminFibri;
  final double? doseExacyl;
  final Map<String, String>? hb;
  final double? doseRivotril;
  final double? doseValium;
  final double? doseManitol;
  final double? doseSshmin;
  final double? doseSshmax;

  const UrgencePage({
    super.key,
    this.dosePropofolEntretien,
    this.poidstext,
    this.doseminPFC,
    this.dosemaxPFC,
    this.doseminPqt,
    this.dosemaxPqt,
    this.doseExacyl,
    this.agemoistext,
    this.hb,
    this.doseGluconateCamax,
    this.doseGluconateCamin,
    this.dosemaxFibri,
    this.doseminFibri,
    this.doseManitol,
    this.doseRivotril,
    this.doseSshmax,
    this.doseSshmin,
    this.doseValium,
  });

  String getBloodVolume() {
    if (agemoistext == null || poidstext == null) {
      return "Age ou poids non specifie";
    }
    double volumePerKg;
    if (agemoistext! < 1) {
      volumePerKg = 95;
    } else if (agemoistext! < 2) {
      volumePerKg = 90;
    } else if (agemoistext! < 13) {
      volumePerKg = 80;
    } else {
      volumePerKg = 70;
    }
    double totalVolume = poidstext! * volumePerKg;
    return "Volume sanguin estime: ${totalVolume.toStringAsFixed(0)} ml";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          if (doseExacyl == null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.pastelOrange.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.pastelOrange.withValues(alpha: 0.6)),
              ),
              child: const Text(
                "Veuillez rentrer le poids et l'age de l'enfant sur l'onglet Anesthesie",
                style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset("assets/images/ours.jpg"),
            ),
          ],
          if (doseExacyl != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Pour un enfant de: ${poidstext!} kg voici les doses recommandees',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark),
              ),
            ),
            const SizedBox(height: 12),

            // Blood Management
            _UrgenceSection(
              title: 'Blood management',
              borderColor: AppColors.pastelRed,
              icon: Icons.bloodtype_outlined,
              children: [
                _UrgenceDoseRow(name: "Taux d'hemoglobine", dose: '${hb!['hb']}'),
                _UrgenceDoseRow(name: getBloodVolume(), dose: ''),
                ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  title: const Text('Seuil transfusionnel', style: TextStyle(fontSize: 14, color: AppColors.textDark)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Nouveau-ne et nourrisson = 10g/dl", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text("Enfant = 8g/dl", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text("Si cardiopathie cyanogene: 12g/dl", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  expandedAlignment: Alignment.topLeft,
                  title: const Text('Transfusion de CGR', style: TextStyle(fontSize: 14, color: AppColors.textDark)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Volume en ml de CGR a transfuser = 3 x (Hb souhaitee - Hb observee) x poids (kg)", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          SizedBox(height: 8),
                          Text("Ratio CGR/PFC/PLQ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                          Text("Si enfant > 30 kg : 1/1/1 (CGR/PFC/PLQ)", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                          Text("Si enfant < 30 kg : 30/20/20 ml/kg (CGR/PFC/PLQ)", style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
                _UrgenceDoseRow(
                  name: 'Volume PFC',
                  dose: '${doseminPFC!.toStringAsFixed(0)} - ${dosemaxPFC!.toStringAsFixed(0)} ml',
                  hint: '10 a 30ml/kg',
                ),
                _UrgenceDoseRow(
                  name: 'Volume plaquettes',
                  dose: '${doseminPqt!.toStringAsFixed(0)} - ${dosemaxPqt!.toStringAsFixed(0)} ml',
                  hint: '15 a 20ml/kg',
                ),
                _UrgenceDoseRow(
                  name: 'Fibrinogene',
                  dose: '${doseminFibri!.toStringAsFixed(2)} - ${dosemaxFibri!.toStringAsFixed(2)} g',
                  hint: '0,03 g/kg jusqu\'a 0.06 g/kg si choc hemorragique',
                ),
                _UrgenceDoseRow(
                  name: 'Exacyl',
                  dose: poidstext! <= 30 ? '${doseExacyl!.toStringAsFixed(0)} mg' : '1g',
                  hint: '10 mg/kg si <30 kg sinon 1g puis 10mg/kg/h PSE',
                ),
                _UrgenceDoseRow(
                  name: 'Gluconate de calcium',
                  dose: '${doseGluconateCamin!.toStringAsFixed(1)} - ${doseGluconateCamax!.toStringAsFixed(0)}mg',
                  hint: '7.5 - 15 mg/kg',
                ),
              ],
            ),

            // Neurologie
            _UrgenceSection(
              title: 'Neurologie',
              borderColor: AppColors.pastelGreen,
              icon: Icons.psychology_outlined,
              children: [
                _UrgenceDoseRow(
                  name: 'Serum Sale Hypertonique',
                  dose: '${doseSshmin!.toStringAsFixed(1)} a ${doseSshmax!.toStringAsFixed(0)} ml',
                  hint: '6.5 a 10ml/kg',
                ),
                _UrgenceDoseRow(
                  name: 'Manitol',
                  dose: '$doseManitol a $poidstext g',
                  hint: '0.5 a 1g/kg sur 20 min',
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 4),
                  child: Text(
                    "Si convulsions",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  ),
                ),
                _UrgenceDoseRow(name: 'Valium', dose: '$doseValium mg', hint: '0.5 mg/kg en IR'),
                _UrgenceDoseRow(name: 'Rivotril', dose: '${doseRivotril!.toStringAsFixed(1)} mg', hint: '0.05 mg/kg en IV'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _UrgenceSection extends StatelessWidget {
  final String title;
  final Color borderColor;
  final IconData? icon;
  final List<Widget> children;

  const _UrgenceSection({
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

class _UrgenceDoseRow extends StatelessWidget {
  final String name;
  final String dose;
  final String? hint;

  const _UrgenceDoseRow({required this.name, required this.dose, this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dose.isEmpty ? name : '$name: $dose',
            style: const TextStyle(fontSize: 15, color: AppColors.textDark),
          ),
          if (hint != null)
            Text(hint!, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
