import 'package:flutter/material.dart';

import '../screens/single_meal_detail.dart';

import '../models/meals.dart';

import './legends_values.dart';

class SingleMealCard extends StatelessWidget {
  final Meal singleMeal;
  final List<Meal> favMeals;
  SingleMealCard(this.singleMeal, this.favMeals);
  String get complexity {
    switch (singleMeal.mealComplexity) {
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      case Complexity.Simple:
        return 'Simple';
      default:
        return 'Unkown';
    }
  }

  String get affordability {
    switch (singleMeal.mealAffordablity) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Expensive:
        return 'Expensive';
      case Affordability.Luxurious:
        return 'Luxurious';
      default:
        return 'Unkown';
    }
  }

  void routeToDetails(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      SingleMealDetail.singleMealRoute,
      arguments: singleMeal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.only(top: 10, bottom: 5),
      width: double.infinity,
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: () => routeToDetails(context),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image(
                // fit: BoxFit.none,
                // height: 250
                image: NetworkImage(
                  singleMeal.mealImageURL,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.black54,
              child: Text(
                singleMeal.mealTitle,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  LegendsValues(
                      "${singleMeal.mealDuration} mins", Icons.schedule),
                  LegendsValues(complexity, Icons.work),
                  LegendsValues(affordability, Icons.attach_money),
                ],
              ),
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              decoration: new BoxDecoration(
                color: (favMeals.contains(singleMeal))
                    ? Colors.orangeAccent[100]
                    : Colors.white,
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
