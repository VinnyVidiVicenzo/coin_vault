import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GradeUtils {
  static Color colorForNumericGrade(num? grade) {
    if (grade == null) return AppColors.gradeGood;
    if (grade >= 60) return AppColors.gradeMint;
    if (grade >= 50) return AppColors.gradeAU;
    if (grade >= 40) return AppColors.gradeEF;
    if (grade >= 20) return AppColors.gradeVF;
    if (grade >= 8)  return AppColors.gradeFine;
    if (grade >= 2)  return AppColors.gradeGood;
    return AppColors.gradePoor;
  }

  // Returns standardized short label: "MS65", "AU58", "VF20", etc.
  static String normalizeGradeLabel(String? grade) => grade?.trim() ?? '—';
}
