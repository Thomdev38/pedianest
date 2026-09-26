import 'package:flutter/material.dart';
import 'package:pedianesth/main.dart';

/// Source : Le Ti’ Pierre pratique, Dr Marie Anaïs, matériel p. 4,
/// hémodynamique p. 6. Repères distincts des tableaux de calcul conservés.
class MemoPediatrique extends StatelessWidget {
  const MemoPediatrique({super.key});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        clipBehavior: Clip.antiAlias,
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          leading: const Icon(Icons.menu_book_outlined,
              color: AppColors.accentTeal, size: 22),
          title: const Text('Repères pédiatriques',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          subtitle: const Text('Matériel et hémodynamique',
              style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          children: [
            LayoutBuilder(builder: (context, constraints) {
              const gap = 12.0;
              final width = constraints.maxWidth >= 680
                  ? (constraints.maxWidth - gap) / 2
                  : constraints.maxWidth;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final card in _cards)
                    SizedBox(width: width, child: card),
                ],
              );
            }),
          ],
        ),
      );

  static const _cards = <Widget>[
    _RepereCard(
      title: 'Ventilation',
      icon: Icons.air_outlined,
      accent: AppColors.primaryBlue,
      children: [
        _GroupLabel('Circuit'),
        _RepereRow('<5 kg', 'Néonatal'),
        _RepereRow('5 à <25 kg', 'Pédiatrique'),
        _RepereRow('≥25 kg', 'Adulte'),
        Divider(height: 24, color: AppColors.borderLight),
        _RepereRow('Sonde IOT', '(poids / 10) + 3',
            detail: 'Diamètre indicatif (mm) · poids en kg'),
        _RepereRow('Repère oral', 'diamètre IOT × 3', detail: 'Repère en cm'),
        _RepereRow('Aspiration', 'Fr ≈ 2 × diamètre IOT'),
        _CardNote(
            'Adaptation clinique possible. Les résultats calculés restent issus des tableaux par poids et du repère oral par âge.'),
      ],
    ),
    _RepereCard(
      title: 'Guedel',
      icon: Icons.medical_services_outlined,
      accent: AppColors.accentTeal,
      children: [
        _RepereRow('Nouveau-né', '000 ou 00', detail: 'Transparente / bleue'),
        _RepereRow('<1 an', '0', detail: 'Grise'),
        _RepereRow('1 à <5 ans', '1', detail: 'Blanche'),
        _RepereRow('5–12 ans', '2 ou 3', detail: 'Verte / orange'),
        _RepereRow('>12 ans', '2 ou 3', detail: 'Verte / orange'),
      ],
    ),
    _RepereCard(
      title: 'Lame de laryngoscope',
      icon: Icons.medical_information_outlined,
      accent: Color(0xFF8B7EC8),
      children: [
        _RepereRow('Nouveau-né', 'Droite 1 ou courbe 0'),
        _RepereRow('<1 an', '1'),
        _RepereRow('1 à <2 ans', '1'),
        _RepereRow('2 à <5 ans', '2'),
        _RepereRow('5–12 ans', '3'),
        _RepereRow('>12 ans', '3'),
        _CardNote(
            'Repères par âge. Le résultat calculé reste déterminé par le poids.'),
      ],
    ),
    _RepereCard(
      title: 'Masque facial',
      icon: Icons.masks_outlined,
      accent: AppColors.primaryBlue,
      children: [
        _RepereRow('Nouveau-né', '0'),
        _RepereRow('<1 an', '1'),
        _RepereRow('1 à <2 ans', '2'),
        _RepereRow('2 à <5 ans', '3'),
        _RepereRow('5–12 ans', '3'),
        _RepereRow('>12 ans', '4'),
      ],
    ),
    _RepereCard(
      title: 'Hémodynamique',
      icon: Icons.monitor_heart_outlined,
      accent: Color(0xFFB4778F),
      children: [
        _GroupLabel('Enfant >1 an'),
        _RepereRow('PAS limite basse', '70 + (2 × âge en années)',
            detail: 'mmHg'),
        Divider(height: 24, color: AppColors.borderLight),
        _GroupLabel('Nouveau-né'),
        _RepereRow('Règle PAM', 'PAM < âge gestationnel à la naissance',
            detail: 'Âge gestationnel en SA'),
      ],
    ),
  ];
}

class _RepereCard extends StatelessWidget {
  const _RepereCard(
      {required this.title,
      required this.icon,
      required this.accent,
      required this.children});
  final String title;
  final IconData icon;
  final Color accent;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Container(
        key: ValueKey('repere-$title'),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accent.withValues(alpha: 0.25)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(icon, size: 19, color: accent),
            const SizedBox(width: 8),
            Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark))),
          ]),
          const SizedBox(height: 14),
          ...children,
        ]),
      );
}

class _RepereRow extends StatelessWidget {
  const _RepereRow(this.label, this.value, {this.detail});
  final String label;
  final String value;
  final String? detail;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 4,
              child: Text(label,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textMuted))),
          const SizedBox(width: 12),
          Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark)),
                  if (detail != null) ...[
                    const SizedBox(height: 2),
                    Text(detail!,
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textMuted)),
                  ],
                ],
              )),
        ]),
      );
}

class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Text(text,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accentTeal)),
      );
}

class _CardNote extends StatelessWidget {
  const _CardNote(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Text(text,
            style: const TextStyle(
                fontSize: 11, height: 1.4, color: AppColors.textMuted)),
      );
}
