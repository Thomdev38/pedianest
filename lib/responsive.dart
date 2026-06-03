import 'package:flutter/material.dart';

/// Helpers de design responsive partagés.
///
/// L'app a été conçue pour smartphone (colonne unique). Ces utilitaires
/// permettent d'adapter l'affichage sur tablette / web sans modifier le
/// rendu mobile : contenu centré avec largeur maximale, mise en page sur
/// deux colonnes, et navigation latérale sur grand écran.
class Responsive {
  Responsive._();

  /// Au-dessus de cette largeur on passe en mise en page "large"
  /// (2 colonnes, padding plus généreux).
  static const double tablet = 720;

  /// Au-dessus de cette largeur on bascule la navigation du bas
  /// vers un NavigationRail latéral.
  static const double navRail = 800;

  /// Largeur maximale du contenu (évite l'étirement sur écrans très larges).
  static const double contentMaxWidth = 1100;

  static bool isWide(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet;
}

/// Centre son enfant et lui applique une largeur maximale + un padding
/// horizontal adaptatif. À utiliser comme enfant direct d'un
/// [SingleChildScrollView] / [ListView].
class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = Responsive.contentMaxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= Responsive.tablet;
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: wide ? 24 : 16,
                vertical: 16,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

/// Affiche une liste de cartes en une seule colonne sur mobile et en deux
/// colonnes "masonry" (indépendantes, hauteurs libres) sur grand écran.
class ResponsiveMasonry extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double breakpoint;

  const ResponsiveMasonry({
    super.key,
    required this.children,
    this.spacing = 12,
    this.breakpoint = Responsive.tablet,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint || children.length < 2) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          );
        }
        final left = <Widget>[];
        final right = <Widget>[];
        for (var i = 0; i < children.length; i++) {
          (i.isEven ? left : right).add(children[i]);
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: left,
              ),
            ),
            SizedBox(width: spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: right,
              ),
            ),
          ],
        );
      },
    );
  }
}
