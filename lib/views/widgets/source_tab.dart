import 'package:flutter/material.dart';
import 'package:news_app_mvvm/models/source_model.dart';

class SourceTab extends StatelessWidget {
  const SourceTab({super.key, required this.source, required this.isSelected});

  final Source source;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Text(
      source.name ?? '',
      style: isSelected
          ? Theme.of(context).textTheme.labelLarge
          : Theme.of(context).textTheme.labelMedium,
    );
  }
}
