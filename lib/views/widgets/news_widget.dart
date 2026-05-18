import 'package:flutter/material.dart';
import 'package:news_app_mvvm/core/widgets/main_error_widget.dart';
import 'package:news_app_mvvm/core/widgets/main_loading_widget.dart';
import 'package:news_app_mvvm/viewmodels/home_viewmodel.dart';
import 'package:news_app_mvvm/viewmodels/news_viewmodel.dart';
import 'package:news_app_mvvm/viewmodels/sources_viewmodel.dart';
import 'package:news_app_mvvm/views/widgets/news_item.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll - 200) {
      context.read<NewsViewModel>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<NewsViewModel>();
    final sourcesVM = context.watch<SourcesViewModel>();

    return switch (vm.state) {
      ViewState.loading || ViewState.idle => const MainLoadingWidget(),
      ViewState.error => MainErrorWidget(
        errorMessage: vm.errorMessage,
        onRetry: () {
          final sources = sourcesVM.sources;
          if (sources.isNotEmpty) {
            context
                .read<NewsViewModel>()
                .loadNews(sources[sourcesVM.selectedTabIndex]);
          }
        },
      ),
      ViewState.success => Builder(
        builder: (context) {
          final homeVM = context.watch<HomeViewModel>();
          final filteredList = homeVM.filterNews(vm.newsList);

          if (filteredList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 60, color: Colors.grey),
                  const SizedBox(height: 12),
                  Text(
                    'No results for "${homeVM.searchQuery}"',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: filteredList.length +
                (vm.hasMore && homeVM.searchQuery.isEmpty ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == filteredList.length) {
                return vm.isLoadingMore
                    ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                )
                    : const SizedBox.shrink();
              }
              return NewsItem(news: filteredList[index]);
            },
          );
        },
      ),
    };
  }
}