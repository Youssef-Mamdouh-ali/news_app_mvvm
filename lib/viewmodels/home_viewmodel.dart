import 'package:flutter/material.dart';
import 'package:news_app_mvvm/models/category_model.dart';
import 'package:news_app_mvvm/models/news_model.dart';


class HomeViewModel extends ChangeNotifier {
  CategoryDataModel? _selectedCategory;
  bool _isSearching = false;
  String _searchQuery = '';

  CategoryDataModel? get selectedCategory => _selectedCategory;
  bool get isSearching => _isSearching;
  String get searchQuery => _searchQuery;
  bool get isCategorySelected => _selectedCategory != null;

  String get appBarTitle =>
      _selectedCategory == null ? 'Home' : _selectedCategory!.categoryName;

  List<News> filterNews(List<News> newsList) {
    if (_searchQuery.isEmpty) return newsList;
    return newsList
        .where((news) =>
    news.title?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
        false)
        .toList();
  }

  void selectCategory(CategoryDataModel category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void goHome() {
    _selectedCategory = null;
    _isSearching = false;
    _searchQuery = '';
    notifyListeners();
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    if (!_isSearching) _searchQuery = '';
    notifyListeners();
  }

  void onSearchChanged(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}