import 'package:flutter/material.dart';

import '../models/category.dart';

import '../screens/single_category.dart';

class SingleCategoryCard extends StatelessWidget {
  final Category cat;
  SingleCategoryCard(this.cat);
  void navigateToSingleCategoryPage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      SingleCategory.singleCategoryRoute,
      arguments: {
        'id': cat.categoryID,
        'title': cat.categoryName,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: InkWell(
        onTap: () => navigateToSingleCategoryPage(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: Text(
            cat.categoryName,
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          cat.categoryBoxColor.withOpacity(0.8),
          cat.categoryBoxColor,
        ]),
      ),
    );
  }
}
