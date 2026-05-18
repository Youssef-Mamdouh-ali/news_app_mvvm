import 'package:flutter/material.dart';
import 'package:news_app_mvvm/models/source_model.dart';
import 'package:news_app_mvvm/services/news_repository.dart';

enum ViewState { idle, loading, success, error }

class SourcesViewModel extends ChangeNotifier {
  final NewsRepository _repository = NewsRepository();

  ViewState _state = ViewState.idle;
  List<Source> _sources = [];
  String _errorMessage = '';
  int _selectedTabIndex = 0;

  ViewState get state => _state;
  List<Source> get sources => _sources;
  String get errorMessage => _errorMessage;
  int get selectedTabIndex => _selectedTabIndex;

  Future<void> loadSources(String categoryId) async {
    _state = ViewState.loading;
    _sources = [];
    notifyListeners();

    try {
      final response = await _repository.getSources(categoryId);
      if (response.status == 'ok') {
        _sources = response.sources ?? [];
        _state = ViewState.success;
      } else {
        _errorMessage = response.message ?? 'Something went wrong';
        _state = ViewState.error;
      }
    } catch (e) {
      _errorMessage = 'Something went wrong';
      _state = ViewState.error;
    }

    notifyListeners();
  }

  void selectTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  void reset() {
    _state = ViewState.idle;
    _sources = [];
    _selectedTabIndex = 0;
    _errorMessage = '';
  }
}
