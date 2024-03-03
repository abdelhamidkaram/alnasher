import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alnsher/core/app_colors.dart';

ThemeData themeData() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.white,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.primaryColor),
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryColor,
      iconTheme: IconThemeData(color: AppColors.white),
      foregroundColor: AppColors.white,
      actionsIconTheme: IconThemeData(color: AppColors.white),
    ),
    useMaterial3: true,
    primaryColor: AppColors.primaryColor,
    focusColor: AppColors.primaryColor,
    cardTheme:
        const CardTheme(color: Colors.white, surfaceTintColor: AppColors.white),
    fontFamily: 'urw',
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
      labelSmall: TextStyle(
          color: AppColors.labelGrey,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold),
    ),
    bottomNavigationBarTheme: const  BottomNavigationBarThemeData(
      unselectedItemColor: AppColors.primaryColor,
       selectedItemColor: AppColors.green,
      showUnselectedLabels: true
    )
  );
}
