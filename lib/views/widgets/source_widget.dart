import 'package:flutter/material.dart';
import 'package:news_app_mvvm/models/source_model.dart';
import 'package:news_app_mvvm/viewmodels/news_viewmodel.dart';
import 'package:news_app_mvvm/viewmodels/sources_viewmodel.dart';
import 'package:news_app_mvvm/views/widgets/news_widget.dart';
import 'package:news_app_mvvm/views/widgets/source_tab.dart';
import 'package:provider/provider.dart';

class SourceWidget extends StatelessWidget {
  const SourceWidget({super.key, required this.sourceList});

  final List<Source> sourceList;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsViewModel(),
      child: _SourceWidgetBody(sourceList: sourceList),
    );
  }
}

class _SourceWidgetBody extends StatefulWidget {
  final List<Source> sourceList;

  const _SourceWidgetBody({required this.sourceList});

  @override
  State<_SourceWidgetBody> createState() => _SourceWidgetBodyState();
}

class _SourceWidgetBodyState extends State<_SourceWidgetBody> {
  @override
  void initState() {
    super.initState();
    if (widget.sourceList.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<NewsViewModel>().loadNews(widget.sourceList[0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sourcesVM = context.watch<SourcesViewModel>();

    return DefaultTabController(
      length: widget.sourceList.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            onTap: (index) {
              sourcesVM.selectTab(index);
              context.read<NewsViewModel>().loadNews(widget.sourceList[index]);
            },
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            indicatorColor: Theme.of(context).splashColor,
            tabs: widget.sourceList.map((source) {
              return SourceTab(
                source: source,
                isSelected:
                    sourcesVM.selectedTabIndex ==
                    widget.sourceList.indexOf(source),
              );
            }).toList(),
          ),
          const Expanded(child: NewsWidget()),
        ],
      ),
    );
  }
}
