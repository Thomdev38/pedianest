import 'package:flutter/material.dart';
import 'package:pedianesth/divers.dart';
import 'package:pedianesth/fiches.dart';
import 'package:pedianesth/homepage.dart';
import 'package:pedianesth/responsive.dart';

void main() {
  runApp(const MainApp());
}

// Palette pastel médicale
class AppColors {
  static const Color primaryBlue = Color(0xFF6BA3BE);
  static const Color lightBlue = Color(0xFF9CC5D8);
  static const Color paleBackground = Color(0xFFF0F4F8);
  static const Color cardBackground = Color(0xFFFAFCFE);
  static const Color accentTeal = Color(0xFF5B9EA6);
  static const Color pastelPink = Color(0xFFE8B4C8);
  static const Color pastelYellow = Color(0xFFF5DEB3);
  static const Color pastelGreen = Color(0xFFA8D5BA);
  static const Color pastelPurple = Color(0xFFB8A9D0);
  static const Color pastelRed = Color(0xFFE0A0A0);
  static const Color pastelOrange = Color(0xFFF0C9A0);
  static const Color textDark = Color(0xFF2C3E50);
  static const Color textMuted = Color(0xFF6B7B8D);
  static const Color borderLight = Color(0xFFD5E1EA);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 0;
  final screens = [
    const PosologieCalculatorScreen(),
    const Fiches(),
    const Divers(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.paleBackground,
        primaryColor: AppColors.primaryBlue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBlue,
          surface: AppColors.paleBackground,
          primary: AppColors.primaryBlue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentTeal,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.borderLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.borderLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
          ),
          labelStyle: const TextStyle(color: AppColors.textMuted),
        ),
        cardTheme: CardThemeData(
          color: AppColors.cardBackground,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        expansionTileTheme: const ExpansionTileThemeData(
          iconColor: AppColors.primaryBlue,
          collapsedIconColor: AppColors.textMuted,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: AppColors.textDark),
          bodyMedium: TextStyle(color: AppColors.textDark),
        ),
      ),
      home: Builder(
        builder: (context) {
          final useRail =
              MediaQuery.of(context).size.width >= Responsive.navRail;
          // Sur grand écran : navigation latérale (NavigationRail).
          if (useRail) {
            return Scaffold(
              body: Row(
                children: [
                  _buildNavigationRail(),
                  const VerticalDivider(width: 1, thickness: 1),
                  Expanded(child: screens[currentIndex]),
                ],
              ),
            );
          }
          // Sur mobile : barre de navigation en bas (comportement d'origine).
          return Scaffold(
            body: screens[currentIndex],
            bottomNavigationBar: _buildBottomNav(),
          );
        },
      ),
    );
  }

  static const _navItems = [
    (icon: Icons.medication_liquid, label: 'Posologie'),
    (icon: Icons.assessment_outlined, label: 'Fiches reflexes'),
    (icon: Icons.settings, label: 'Divers'),
  ];

  Widget _buildNavigationRail() {
    return NavigationRail(
      backgroundColor: AppColors.primaryBlue,
      selectedIndex: currentIndex,
      onDestinationSelected: (index) => setState(() => currentIndex = index),
      labelType: NavigationRailLabelType.all,
      indicatorColor: Colors.white.withValues(alpha: 0.2),
      selectedIconTheme: const IconThemeData(color: Colors.white, size: 28),
      unselectedIconTheme: const IconThemeData(color: Colors.white70, size: 26),
      selectedLabelTextStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
      destinations: [
        for (final item in _navItems)
          NavigationRailDestination(
            icon: Icon(item.icon),
            label: Text(item.label),
          ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primaryBlue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 13,
        unselectedFontSize: 12,
        iconSize: 28,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          for (final item in _navItems)
            BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
            ),
        ],
      ),
    );
  }
}
