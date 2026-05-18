import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_style.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.whiteColor,
    splashColor: AppColors.darkColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      iconTheme: IconThemeData(color: AppColors.darkColor),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      labelLarge: AppStyle.bold16Black,
      labelSmall: AppStyle.medium12Grey,
      labelMedium: AppStyle.medium14Black,
      headlineMedium: AppStyle.medium24Black,
      headlineLarge: AppStyle.medium20Black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.darkColor,
    splashColor: AppColors.whiteColor,
    scaffoldBackgroundColor: AppColors.darkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColor,
      iconTheme: IconThemeData(color: AppColors.whiteColor),
      centerTitle: true,
    ),
    textTheme: TextTheme(
      labelLarge: AppStyle.bold16White,
      labelSmall: AppStyle.medium12Grey,
      labelMedium: AppStyle.medium14White,
      headlineMedium: AppStyle.medium24White,
      headlineLarge: AppStyle.medium20White,
    ),
  );
}
