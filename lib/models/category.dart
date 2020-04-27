import 'package:flutter/material.dart';

class Category {
  final Color categoryBoxColor;
  final String categoryName;
  final String categoryID;

  const Category({
    this.categoryBoxColor = Colors.purpleAccent,
    this.categoryID,
    this.categoryName,
  });
}
