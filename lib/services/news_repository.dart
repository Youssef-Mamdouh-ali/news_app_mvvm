
import 'package:news_app_mvvm/models/news_model.dart';
import 'package:news_app_mvvm/models/source_model.dart';

import 'api_service.dart';

class NewsRepository {
  Future<SourceResponse> getSources(String categoryId) async {
    final json = await ApiService.getSources(categoryId);
    return SourceResponse.fromJson(json);
  }

  Future<NewsResponse> getNewsBySourceId(String sourceId, {int page = 1}) async {
    final json = await ApiService.getNewsBySourceId(sourceId, page: page);
    return NewsResponse.fromJson(json);
  }
}
