import 'package:flutter/material.dart';
import 'package:news_app_mvvm/models/category_model.dart';
import 'package:news_app_mvvm/viewmodels/home_viewmodel.dart';
import 'package:news_app_mvvm/views/widgets/custom_category_card.dart';
import 'package:provider/provider.dart';

class HomeCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good Morning',
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 5),
            Text('Here is Some News For You',
                style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            ...List.generate(CategoryDataModel.categoryList.length, (index) {
              return CustomCategoryCard(
                categoryData: CategoryDataModel.categoryList[index],
                categoryIndex: index,
                onTap: (category) {
                  context.read<HomeViewModel>().selectCategory(category);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}