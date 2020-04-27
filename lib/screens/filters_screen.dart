import 'package:flutter/material.dart';
// import '../screens/my_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  final Map<String, bool> myFilters;
  final Function settingFilters;
  FiltersScreen(this.myFilters, this.settingFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree;
  bool _lactoseFree;
  bool _vegan;
  bool _vegitarean;
  @override
  initState() {
    _glutenFree = widget.myFilters["Gluten"];
    _vegitarean = widget.myFilters["Vegetarian"];
    _lactoseFree = widget.myFilters["Lactose"];
    _vegan = widget.myFilters["Vegan"];
    super.initState();
  }

  Widget _listViewBuilding(
    String title,
    String description,
    bool prop,
    Function update,
  ) {
    return SwitchListTile(
      onChanged: update,
      value: prop,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontFamily: "Raleway",
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        description,
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Raleway",
          color: Colors.black,
          fontWeight: FontWeight.w100,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.black,
            ),
            onPressed: () {
              final Map<String, bool> _myFilter = {
                "Gluten": _glutenFree,
                "Lactose": _lactoseFree,
                "Vegetarian": _vegitarean,
                "Vegan": _vegan,
              };
              widget.settingFilters(
                _myFilter,
              );
            },
          )
        ],
        title: Text("Filters"),
        leading: Icon(
          Icons.sort,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("/");
        },
        child: Icon(
          Icons.home,
          color: Colors.black,
        ),
      ),
      // endDrawer: MyDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Text(
              "Tune it up to your Diet!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.body2,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _listViewBuilding(
                  "Gluten-Free",
                  "Show Only Those Meals that are Gluten Free",
                  _glutenFree,
                  (newState) {
                    setState(
                      () {
                        _glutenFree = newState;
                      },
                    );
                  },
                ),
                _listViewBuilding(
                    "Lactose-Free",
                    "Show Only Those Meals that are Lactose Free",
                    _lactoseFree, (newState) {
                  setState(() {
                    _lactoseFree = newState;
                  });
                }),
                _listViewBuilding(
                    "Vegiterean",
                    "Show Only Those Meals that are Vegiterean",
                    _vegitarean, (newState) {
                  setState(() {
                    _vegitarean = newState;
                  });
                }),
                _listViewBuilding(
                    "Vegan", "Show Only Those Meals that are Vegan", _vegan,
                    (newState) {
                  setState(() {
                    _vegan = newState;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
