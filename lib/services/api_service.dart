import 'package:dio/dio.dart';
import 'package:news_app_mvvm/core/api_constant/api_constant.dart';
import 'package:news_app_mvvm/core/api_constant/end_points.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConstant.baseUrl,
            queryParameters: {'apiKey': ApiConstant.apiKey},
          ),
        )
        ..interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
          ),
        );

  static Future<Map<String, dynamic>> getSources(String categoryId) async {
    final response = await _dio.get(
      EndPoints.sourcesEndpoint,
      queryParameters: {'category': categoryId},
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> getNewsBySourceId(
    String sourceId, {
    int page = 1,
  }) async {
    final response = await _dio.get(
      EndPoints.newsEndpoint,
      queryParameters: {'sources': sourceId, 'page': page, 'pageSize': 10},
    );
    return response.data;
  }
}
