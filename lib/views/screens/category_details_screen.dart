import 'package:flutter/material.dart';
import 'package:news_app_mvvm/core/widgets/main_error_widget.dart';
import 'package:news_app_mvvm/core/widgets/main_loading_widget.dart';
import 'package:news_app_mvvm/viewmodels/sources_viewmodel.dart';
import 'package:news_app_mvvm/views/widgets/source_widget.dart';
import 'package:provider/provider.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final String categoryId;

  const CategoryDetailsScreen({super.key, required this.categoryId});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SourcesViewModel>().loadSources(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SourcesViewModel>();

    return switch (vm.state) {
      ViewState.loading || ViewState.idle => const MainLoadingWidget(),
      ViewState.error => MainErrorWidget(
          errorMessage: vm.errorMessage,
          onRetry: () => context
              .read<SourcesViewModel>()
              .loadSources(widget.categoryId),
        ),
      ViewState.success => SourceWidget(sourceList: vm.sources),
    };
  }
}
