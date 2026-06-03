import 'package:flutter/material.dart';
import 'package:pedianesth/divers.dart';
import 'package:pedianesth/fiches.dart';
import 'package:pedianesth/homepage.dart';

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
      home: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: Container(
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.medication_liquid),
                label: "Posologie",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assessment_outlined),
                label: "Fiches reflexes",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Divers",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
