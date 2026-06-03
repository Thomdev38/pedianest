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
              const SizedBox(height: 16),
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
