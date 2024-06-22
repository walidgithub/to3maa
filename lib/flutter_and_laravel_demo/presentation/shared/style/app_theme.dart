import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_laravel/flutter_and_laravel_demo/presentation/shared/constant/app_constants.dart';
import 'package:flutter_laravel/flutter_and_laravel_demo/presentation/shared/style/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/app_typography.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kPrimary),
      primarySwatch: Colors.teal,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.kBackground,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: AppColors.kBlack,
        ),
        backgroundColor: AppColors.kBackground,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppConstants.heightBetweenElements,
          vertical: 16.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        hintStyle: AppTypography.kLight14,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppConstants.heightBetweenElements,
          vertical: 16.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        hintStyle: AppTypography.kLight14,
      )),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.kBackground,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ));
}

// Default Overlay.
SystemUiOverlayStyle defaultOverlay = const SystemUiOverlayStyle(
  statusBarColor: AppColors.kTransparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: AppColors.kBlack,
  systemNavigationBarDividerColor: AppColors.kTransparent,
  systemNavigationBarIconBrightness: Brightness.light,
);
