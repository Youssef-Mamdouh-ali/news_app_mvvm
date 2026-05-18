import 'package:flutter/material.dart';
import 'package:news_app_mvvm/viewmodels/theme_viewmodel.dart';
import 'package:provider/provider.dart';

import 'core/app_theme/app_theme.dart';
import 'core/routes_manager/app_router.dart';
import 'core/routes_manager/app_routes.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = context.watch<ThemeViewModel>();

    return MaterialApp(
      title: 'News',
      initialRoute: AppRoutes.homeRouteName,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeVM.themeMode,
    );
  }
}