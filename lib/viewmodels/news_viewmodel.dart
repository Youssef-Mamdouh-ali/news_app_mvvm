import 'package:flutter/material.dart';
import 'package:news_app_mvvm/models/news_model.dart';
import 'package:news_app_mvvm/models/source_model.dart';
import 'package:news_app_mvvm/services/news_repository.dart';

import 'sources_viewmodel.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsRepository _repository = NewsRepository();

  ViewState _state = ViewState.idle;
  List<News> _newsList = [];
  String _errorMessage = '';

  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  Source? _currentSource;

  ViewState get state => _state;
  List<News> get newsList => _newsList;
  String get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> loadNews(Source source) async {
    _currentSource = source;
    _currentPage = 1;
    _hasMore = true;
    _newsList = [];
    _state = ViewState.loading;
    notifyListeners();

    try {
      final response = await _repository.getNewsBySourceId(
        source.id ?? '',
        page: _currentPage,
      );
      if (response.status == 'ok') {
        _newsList = response.articles ?? [];
        _hasMore = (_newsList.length >= 10);
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

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore || _currentSource == null) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      _currentPage++;
      final response = await _repository.getNewsBySourceId(
        _currentSource!.id ?? '',
        page: _currentPage,
      );
      if (response.status == 'ok') {
        final newArticles = response.articles ?? [];
        _newsList.addAll(newArticles);
        _hasMore = (newArticles.length >= 10);
      } else {
        _currentPage--;
      }
    } catch (e) {
      _currentPage--;
    }

    _isLoadingMore = false;
    notifyListeners();
  }
}