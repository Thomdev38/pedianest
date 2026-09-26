import 'package:flutter/material.dart';
import 'package:pedianesth/information.dart';
import 'package:pedianesth/main.dart';
import 'package:pedianesth/policie.dart';
import 'package:pedianesth/responsive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pedianesth/sources.dart';

class Divers extends StatefulWidget {
  const Divers({super.key});

  @override
  State<Divers> createState() => _DiversState();
}

class _DiversState extends State<Divers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Divers'),
      ),
      body: SingleChildScrollView(
        child: ResponsiveCenter(
          maxWidth: 600,
          child: Column(
            children: [
              const _PosologiesInfoCard(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _DiversCard(
                      icon: Icons.info_outline,
                      label: 'Informations',
                      color: AppColors.primaryBlue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Information()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _DiversCard(
                      icon: Icons.menu_book_outlined,
                      label: 'Sources',
                      color: AppColors.accentTeal,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Sources()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _DiversButton(
                icon: Icons.privacy_tip_outlined,
                label: 'Politique de confidentialite',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Policie()),
                  );
                },
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _DiversButton(
                      icon: Icons.email_outlined,
                      label: 'Contactez moi',
                      onTap: _sendEmail,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _DiversButton(
                      icon: Icons.language,
                      label: 'Deviade.fr',
                      onTap: _openWebsite,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'thomas.deviade@gmail.com',
      query: 'subject=Application Pedianesth',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _openWebsite() async {
    final Uri url = Uri.parse("https://thomdev38.github.io/deviade/");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}

class _PosologiesInfoCard extends StatelessWidget {
  const _PosologiesInfoCard();

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 15,
      height: 1.55,
      color: AppColors.textDark,
    );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9FD),
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.15)),
      ),
      child: DefaultTextStyle(
        style: bodyStyle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Icon(Icons.info_outline_rounded,
                      size: 22, color: AppColors.primaryBlue),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'À propos des posologies pédiatriques',
                    style: TextStyle(
                      fontSize: 19,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Je suis Thomas Templier, infirmier anesthésiste.'),
            const SizedBox(height: 16),
            const Text(
              'Je ne suis pas spécialisé en pédiatrie, et les contenus de cette application sont donc mis à jour progressivement grâce aux retours des utilisateurs et aux protocoles qui me sont transmis.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Je continue à maintenir cette application en ligne, mais je n’ai pas aujourd’hui le temps de refaire une revue complète de la littérature en anesthésie pédiatrique.',
            ),
            const SizedBox(height: 16),
            const Text(
              'En revanche, je mets volontiers l’application à jour lorsqu’on me transmet :',
            ),
            const SizedBox(height: 10),
            for (final item in const [
              'des protocoles utilisés en pratique,',
              'des recommandations de la SFAR,',
              'ou des références de sociétés d’anesthésie pédiatrique.',
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('•  ',
                        style: TextStyle(color: AppColors.primaryBlue)),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            const Text(
              'Vos retours permettent d’améliorer l’application au fil du temps.',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1, color: AppColors.borderLight),
            ),
            const Text(
              'Cette application ne remplace pas les protocoles de votre structure ni l’avis d’un professionnel formé à la pédiatrie.',
              style: TextStyle(
                fontSize: 13.5,
                height: 1.5,
                color: Color(0xFF53667B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiversCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _DiversCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withValues(alpha: 0.12),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DiversButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DiversButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
    );
  }
}
