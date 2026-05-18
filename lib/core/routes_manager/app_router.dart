import 'package:flutter/material.dart';
import 'package:news_app_mvvm/viewmodels/home_viewmodel.dart';
import 'package:news_app_mvvm/viewmodels/sources_viewmodel.dart';
import 'package:news_app_mvvm/views/screens/home_screen.dart';

import 'package:provider/provider.dart';

import 'app_routes.dart';

abstract class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRouteName:
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => HomeViewModel()),
              ChangeNotifierProvider(create: (_) => SourcesViewModel()),
            ],
            child: const HomeScreen(),
          ),
          settings: settings,
        );
      default:
        return null;
    }
  }
}
