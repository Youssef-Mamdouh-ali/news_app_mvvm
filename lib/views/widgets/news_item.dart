import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_mvvm/core/app_theme/app_style.dart';
import 'package:news_app_mvvm/core/widgets/main_loading_widget.dart';
import 'package:news_app_mvvm/models/news_model.dart';
import 'package:news_app_mvvm/views/widgets/news_bottom_sheet.dart';
import 'package:intl/intl.dart';


class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => NewsBottomSheet(news: news),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).splashColor, width: 2),
        ),
        child: Column(
          spacing: height * 0.01,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: news.urlToImage ?? '',
                placeholder: (context, url) => const MainLoadingWidget(),
                errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image),
              ),
            ),
            Text(
              news.title ?? '',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'By: ${news.author ?? "Unknown"}',
                    style: AppStyle.medium12Grey,
                  ),
                ),
                Text(_formatDate(news.publishedAt), style: AppStyle.medium12Grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }
}