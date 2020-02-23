
import 'package:flutter/cupertino.dart';
import 'package:kampusell/model/category.dart';
import 'package:flutter/material.dart';

import 'category-item.dart';

class CategoriesList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final List<Category> categories = Category.fetchAll();
    return ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 15.0,
          maxHeight: 70.0,
        ),
        child:ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: categories.map((category)=> CategoryItem(category)).toList(),
        )
    );

  }

}