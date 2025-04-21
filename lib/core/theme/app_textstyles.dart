import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  // Base style (only defines the font family)
  static TextStyle get baseStyle => GoogleFonts.poppins();

  // Variants using copyWith

  static TextStyle get t12b400_936 => baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGreyColor936,
  );

  static TextStyle get t12b500_936 => baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGreyColor936,
  );

  static TextStyle get t12b600_EFF => baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.brandColorEFF,
  );

  static TextStyle get t14b400_936 => baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGreyColor936,
  );

  static TextStyle get t14b600_936 => baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGreyColor936,
  );

  static TextStyle get t16b400_936 => baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGreyColor936,
  );

  static TextStyle get t14b600_EFF => baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.brandColorEFF
  );

  static TextStyle get t16b600_936 => baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGreyColor936,
  );

  static TextStyle get t20b700_000 => baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle get t20b800_EEF => baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.brandColorEFF,
  );

  static TextStyle get t24b700_000 => baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static TextStyle get t24b700_EFF => baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.brandColorEFF,
  );


}

