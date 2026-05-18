import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_mvvm/core/app_theme/app_style.dart';
import 'package:news_app_mvvm/core/widgets/main_loading_widget.dart';
import 'package:news_app_mvvm/models/news_model.dart';

import 'package:url_launcher/url_launcher.dart';

class NewsBottomSheet extends StatelessWidget {
  const NewsBottomSheet({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.all(20),
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey..withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              if (news.urlToImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: news.urlToImage!,
                    placeholder: (context, url) => const MainLoadingWidget(),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image),
                  ),
                ),

              const SizedBox(height: 16),

              Text(
                news.title ?? '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(Icons.person_outline, size: 16,
                      color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      news.author ?? 'Unknown',
                      style: AppStyle.medium12Grey,
                    ),
                  ),
                  const Icon(Icons.access_time, size: 16,
                      color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(news.publishedAt),
                    style: AppStyle.medium12Grey,
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.grey.withOpacity(0.3)),
              const SizedBox(height: 16),

              Text(
                news.description ?? '',
                style: Theme.of(context).textTheme.labelMedium,
              ),

              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: () => _openInBrowser(news.url),
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Read Full Article'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return dateStr;
    }
  }

  Future<void> _openInBrowser(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}