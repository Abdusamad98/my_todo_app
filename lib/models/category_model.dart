import 'package:flutter/material.dart';

class CategoryModel {
  CategoryModel({
    required this.categoryName,
    required this.categoryColor,
    required this.categoryId,
    required this.iconPath,
  });

  final int categoryId;
  final String iconPath;
  final String categoryName;
  final Color categoryColor;
}
