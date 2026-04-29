import 'package:flutter/material.dart';

class AppColors {
  // Primary palette — deep space navy
  static const primary = Color(0xFF0A0E27);
  static const primaryMid = Color(0xFF141B45);
  static const primaryLight = Color(0xFF1E2B6B);
  static const primarySurface = Color(0xFF0D1230);

  // Accent — electric gold
  static const accent = Color(0xFFFFBB00);
  static const accentDark = Color(0xFFCC9500);
  static const accentGlow = Color(0x33FFBB00);

  // Cyan highlight — futuristic pop
  static const cyan = Color(0xFF00D4FF);
  static const cyanGlow = Color(0x2200D4FF);

  // Surface
  static const surface = Color(0xFFF7F8FC);
  static const surfaceDark = Color(0xFF0F1535);
  static const cardLight = Colors.white;

  // Semantic
  static const error = Color(0xFFFF4560);
  static const success = Color(0xFF00C896);
  static const warning = Color(0xFFFFBB00);

  // Grade tier colors
  static const gradeMint = Color(0xFF00C896);
  static const gradeAU = Color(0xFF00B4D8);
  static const gradeEF = Color(0xFFFFBB00);
  static const gradeVF = Color(0xFFFF8C42);
  static const gradeFine = Color(0xFFFF4560);
  static const gradeGood = Color(0xFF8B8FA8);
  static const gradePoor = Color(0xFF565B73);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF141B45), Color(0xFF0A0E27)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFFFBB00), Color(0xFFFF8C00)],
  );

  static const LinearGradient cyanGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF0F2FF)],
  );
}
