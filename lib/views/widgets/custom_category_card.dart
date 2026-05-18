import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:news_app_mvvm/models/category_model.dart';

class CustomCategoryCard extends StatelessWidget {
  final CategoryDataModel categoryData;
  final int categoryIndex;
  final Function(CategoryDataModel) onTap;

  const CustomCategoryCard({
    super.key,
    required this.categoryIndex,
    required this.categoryData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).splashColor,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(categoryData.categoryImage),
          alignment: categoryIndex % 2 == 0
              ? AlignmentGeometry.centerLeft
              : AlignmentGeometry.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: categoryIndex % 2 == 0
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              categoryData.categoryName,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            Bounceable(
              onTap: () => onTap(categoryData),
              child: Container(
                alignment: Alignment.centerRight,
                height: 50,
                width: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'View All',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(width: 5),
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                      foregroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                      radius: 25,
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
