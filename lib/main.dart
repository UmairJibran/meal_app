import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './dummy/dummy_categories.dart';

import './models/meals.dart';

import './screens/favorities.dart';
// import './screens/my_drawer.dart';
import './screens/categories_screen.dart';
import './screens/single_category.dart';
import './screens/single_meal_detail.dart';
import './screens/last_resort.dart';
import './screens/filters_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _myFilter = {
    "Gluten": false,
    "Lactose": false,
    "Vegetarian": false,
    "Vegan": false,
  };
  List<Meal> _myDisplayableMeals = DUMMY_MEALS;
  List<Meal> _favMeals = [];

  bool isFav(String myMealID) {
    return _favMeals.any((meal) => meal.mealID == myMealID);
  }

  void toggleFav(String myMealID) {
    final existingIndex =
        _favMeals.indexWhere((meal) => meal.mealID == myMealID);
    if (existingIndex >= 0) {
      setState(() {
        _favMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favMeals.add(DUMMY_MEALS.firstWhere((meal) {
          return meal.mealID == myMealID;
        }));
      });
    }
  }

  void _setFilters(Map<String, bool> updatedFilters) {
    _myFilter = updatedFilters;

    setState(() {
      _myFilter = updatedFilters;
      _myDisplayableMeals = DUMMY_MEALS.where((meal) {
        if (_myFilter["Gluten"] && !meal.isMealGlutenFree) return false;
        if (_myFilter["Lactose"] && !meal.isMealLactoseFree) return false;
        if (_myFilter["Vegan"] && !meal.isMealVegan) return false;
        if (_myFilter["Vegetarian"] && !meal.isMealVegetarian) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.redAccent[100],
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
        ),
        // primarySwatch: Colors.purpleAccent[300],
        primaryColor: Colors.purpleAccent[300],
        accentColor: Colors.yellowAccent[100],
        // accentColor: Colors.white,
        canvasColor: Colors.lightBlueAccent[100],
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              body2: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).primaryColorDark,
              ),
              title: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
      ),
      title: 'Meal App',
      // home: MyHomePage(),
      routes: {
        "/": (ctx) => MyHomePage(_favMeals),
        SingleCategory.singleCategoryRoute: (ctx) =>
            SingleCategory(_myDisplayableMeals, _favMeals),
        SingleMealDetail.singleMealRoute: (ctx) =>
            SingleMealDetail(toggleFav, isFav),
        // MyLastResort.goHome: (ctx) => MyHomePage(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              _myFilter,
              _setFilters,
            ),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => MyLastResort(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Meal> favMeals;
  MyHomePage(this.favMeals);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // endDrawer: MyDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              FiltersScreen.routeName,
            );
          },
          child: Icon(
            Icons.sort,
            color: Colors.black,
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
          leading: Icon(
            Icons.home,
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.category,
                      size: 20,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Categories",
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Favourities",
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          elevation: 20,
          title: Center(
            child: Text(
              "Meal App",
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CategoriesScreen(),
            Favorities(
              widget.favMeals,
            ),
          ],
        ),
      ),
    );
  }
}
