import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Doktor oyunu renk paleti
  static const Color background = Color(0xFF0A1628);      // Koyu lacivert
  static const Color surface = Color(0xFF132038);          // Yüzey
  static const Color surfaceLight = Color(0xFF1B2D4A);     // Açık yüzey
  static const Color primary = Color(0xFF00BFA5);          // Teal (tıbbi yeşil)
  static const Color secondary = Color(0xFF42A5F5);        // Mavi
  static const Color accent = Color(0xFF66BB6A);           // Yeşil (başarı)
  static const Color danger = Color(0xFFEF5350);           // Kırmızı (acil)
  static const Color warning = Color(0xFFFFB74D);          // Turuncu (uyarı)
  static const Color gold = Color(0xFFFFD54F);             // Altın (ödül)

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      surface: surface,
      error: danger,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: surface,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      color: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: primary.withValues(alpha: 0.2)),
      ),
    ),
  );
}
