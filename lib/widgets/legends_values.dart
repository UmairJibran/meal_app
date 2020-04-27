import 'package:flutter/material.dart';

class LegendsValues extends StatelessWidget {
  var legendValue;
  var legendIcon;

  LegendsValues(
    this.legendValue,
    this.legendIcon,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            legendIcon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(legendValue),
        ],
      ),
    );
  }
}
