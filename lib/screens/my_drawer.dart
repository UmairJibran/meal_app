import 'package:flutter/material.dart';

import './filters_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black54,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.6,
                  child: Container(
                    color: Colors.green,
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      "Menu",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                        fontFamily: "Raleway",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
              child: Container(
                color: Colors.green,
              ),
            ),
            Divider(
              height: 1,
              // thickness: 1,
              color: Colors.white,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              splashColor: Colors.black,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.restaurant_menu,
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Meals",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Raleway",
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              // thickness: 1,
              color: Colors.white,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(FiltersScreen.routeName);
              },
              splashColor: Colors.black,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.sort,
                      color: Colors.white,
                      size: 40,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Filters",
                      style: TextStyle(
                        fontFamily: "Raleway",
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
