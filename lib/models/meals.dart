import 'package:flutter/foundation.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard,
}

enum Affordability {
  Affordable,
  Expensive,
  Luxurious,
}

class Meal {
  final String mealID;
  final List<String> mealCategories;
  final String mealTitle;
  final String mealImageURL;
  final List<String> mealIngredients;
  final List<String> mealSteps;
  final int mealDuration;
  final Complexity mealComplexity;
  final Affordability mealAffordablity;
  final bool isMealLactoseFree;
  final bool isMealGlutenFree;
  final bool isMealVegan;
  final bool isMealVegetarian;

  const Meal({
    @required this.isMealGlutenFree,
    @required this.isMealLactoseFree,
    @required this.isMealVegan,
    @required this.isMealVegetarian,
    @required this.mealAffordablity,
    @required this.mealCategories,
    @required this.mealComplexity,
    @required this.mealDuration,
    @required this.mealID,
    @required this.mealImageURL,
    @required this.mealIngredients,
    @required this.mealSteps,
    @required this.mealTitle,
  });
}
