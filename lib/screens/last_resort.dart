import 'package:flutter/material.dart';

class MyLastResort extends StatelessWidget {
  static const goHome = "/HomePage";
  void routeToHome(BuildContext ctx) {
    Navigator.of(ctx).popAndPushNamed("/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uh-oh!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            Icons.restaurant,
            color: Colors.black,
            size: MediaQuery.of(context).size.height * 0.5,
          ),
          Column(
            children: <Widget>[
              Text(
                "Oh, it isn't cooked yet,",
              ),
              Text(
                "You Might wanna check on it Later!",
              ),
            ],
          ),
          Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor: Colors.black,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                    )),
                height: 40,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Go Back!",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
