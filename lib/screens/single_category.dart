import "package:flutter/material.dart";

// import '../dummy/dummy_categories.dart';
import '../models/meals.dart';
import '../widgets/single_meal_card.dart';

class SingleCategory extends StatelessWidget {
  final List<Meal> myMeals;
  final List<Meal> favs;
  SingleCategory(this.myMeals, this.favs);
  // final String categoryID;
  // final String categoryName;
  // SingleCategory(this.categoryID, this.categoryName);
  static const singleCategoryRoute = '/SingleCategory';
  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryName = routeArguments['title'];
    final categoryID = routeArguments['id'];
    final categoryMeals = myMeals.where((singleMeal) {
      return singleMeal.mealCategories.contains(categoryID);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/Messages-Page");
            },
            icon: Icon(
              Icons.message,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (_, index) {
          return Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: SingleMealCard(categoryMeals[index], favs),
            ),
          );
        },
      ),
    );
  }
}
