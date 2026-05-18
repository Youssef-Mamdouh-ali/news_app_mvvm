import 'package:flutter/material.dart';
import 'package:news_app_mvvm/core/app_theme/app_colors.dart';

class MainLoadingWidget extends StatelessWidget {
  const MainLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.greyColor),
    );
  }
}
