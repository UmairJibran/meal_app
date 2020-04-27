import 'package:flutter/material.dart';

import '../models/meals.dart';

class SingleMealDetail extends StatelessWidget {
  final Function toggleFav;
  final Function isFav;
  SingleMealDetail(this.toggleFav, this.isFav);
  static const singleMealRoute = "/SingleMeal";
  Meal singleMeal;
  @override
  Widget build(BuildContext context) {
    final Meal routeArguments = ModalRoute.of(context).settings.arguments;
    singleMeal = routeArguments;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          mini: true,
          onPressed: () => toggleFav(singleMeal.mealID),
          child: Icon(
            // Icons.star,
            (isFav(singleMeal.mealID)) ? Icons.star : Icons.star_border,
            color: Colors.deepOrange,
          ),
        ),
        appBar: AppBar(
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
          title: Text(
            routeArguments.mealTitle,
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            height: 300,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(60),
              ),
              child: Image.network(
                routeArguments.mealImageURL,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 5,
            ),
            child: Text(
              "Ingredients",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title,
            ),
            color: Colors.grey,
            width: double.infinity,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: routeArguments.mealIngredients.map((ingredient) {
                return Text(ingredient);
              }).toList(),
            ),
            // child: ListView.builder(
            //   itemCount: routeArguments.mealIngredients.length,
            //   itemBuilder: (_, index) => Column(
            //     children: <Widget>[
            //       Container(
            //         padding: EdgeInsets.all(10),
            //         child: Row(
            //           children: <Widget>[
            //             Text(
            //               "${index + 1}. ",
            //               style: TextStyle(
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.black,
            //               ),
            //             ),
            //             Text(
            //               routeArguments.mealIngredients[index],
            //               style: TextStyle(
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.black,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       Divider(
            //         thickness: 1,
            //         color: Colors.grey,
            //       ),
            //     ],
            //   ),
            // ),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          Container(
            padding: EdgeInsets.only(
              top: 5,
            ),
            child: Text(
              "Steps to Prepare",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title,
            ),
            color: Colors.grey,
            width: double.infinity,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            //   child: ListView.builder(
            //       itemCount: routeArguments.mealSteps.length,
            //       itemBuilder: (_, index) => Column(
            //             children: <Widget>[
            //               Container(
            //                 padding: EdgeInsets.all(10),
            //                 child: Row(
            //                   children: <Widget>[
            //                     ClipRRect(
            //                       borderRadius: BorderRadius.circular(20),
            //                       child: Container(
            //                         height: 30,
            //                         width: 30,
            //                         color: Theme.of(context).accentColor,
            //                         child: Center(
            //                           child: Text(
            //                             "${index + 1}",
            //                             textAlign: TextAlign.start,
            //                             style: TextStyle(
            //                                 fontSize: 15,
            //                                 fontWeight: FontWeight.bold,
            //                                 color: Colors.black),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Container(
            //                       margin: EdgeInsets.only(left: 15),
            //                       child: Text(
            //                         " " + routeArguments.mealSteps[index],
            //                         softWrap: true,
            //                         overflow: TextOverflow.fade,
            //                         style: TextStyle(
            //                           fontSize: 15,
            //                           fontWeight: FontWeight.bold,
            //                           color: Colors.black,
            //                         ),
            //                       ),
            //                       // width: 350,
            //                       width: MediaQuery.of(context).size.width * 0.75,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Divider(
            //                 thickness: 1,
            //                 color: Colors.grey,
            //               ),
            //             ],
            //           )),
            //   height: MediaQuery.of(context).size.height * 0.5,
            //   width: MediaQuery.of(context).size.width,
            child: Column(
              children: routeArguments.mealSteps.map((ingredient) {
                return Text(ingredient);
              }).toList(),
            ),
          )
        ]))));
  }
}
