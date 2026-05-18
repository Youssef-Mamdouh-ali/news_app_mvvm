import 'package:flutter/material.dart';
import 'package:news_app_mvvm/viewmodels/home_viewmodel.dart';
import 'package:news_app_mvvm/views/screens/category_details_screen.dart';
import 'package:news_app_mvvm/views/screens/home_categories.dart';
import 'package:news_app_mvvm/views/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeVM = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: homeVM.isSearching
            ? TextField(
          autofocus: true,
          onChanged: context.read<HomeViewModel>().onSearchChanged,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
            hintText: 'Search news...',
            hintStyle: Theme.of(context).textTheme.labelSmall,
            border: InputBorder.none,
          ),
        )
            : Text(
          homeVM.appBarTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: [
          // لو مش في category مش هيظهر الـ search
          if (homeVM.isCategorySelected)
            IconButton(
              onPressed: context.read<HomeViewModel>().toggleSearch,
              icon: Icon(
                homeVM.isSearching ? Icons.close : Icons.search,
                size: 28,
              ),
            ),
        ],
      ),
      drawer: CustomDrawer(
        onHomeTap: () {
          context.read<HomeViewModel>().goHome();
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: homeVM.isCategorySelected
            ? CategoryDetailsScreen(
          categoryId: homeVM.selectedCategory!.categoryId,
        )
            : HomeCategories(),
      ),
    );
  }
}

