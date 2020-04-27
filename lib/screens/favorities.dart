import 'package:flutter/material.dart';

import '../models/meals.dart';
import '../widgets/single_meal_card.dart';

class Favorities extends StatelessWidget {
  final List<Meal> favMeals;
  Favorities(this.favMeals);
  @override
  Widget build(BuildContext context) {
    if (favMeals.isEmpty) {
      return Center(
        child: Text("Favourties Data"),
      );
    } else {
      return ListView.builder(
        itemCount: favMeals.length,
        itemBuilder: (_, index) {
          return Container(
            child: Center(
              child: SingleMealCard(favMeals[index], favMeals),
            ),
          );
        },
      );
    }
  }
}
