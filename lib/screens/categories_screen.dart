import 'package:flutter/material.dart';

import '../widgets/single_category_card.dart';

import '../dummy/dummy_categories.dart';

class CategoriesScreen extends StatelessWidget {
  // final myMeals;
  // CategoriesScreen(this.myMeals);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 0,
        ),
        itemBuilder: (_, index) {
          return SingleCategoryCard(
            DUMMY_CATEGORIES[index],
          );
        },
        itemCount: DUMMY_CATEGORIES.length,
      ),
    );
  }
}
