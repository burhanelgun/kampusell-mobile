import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/category-item.dart';
import 'package:kampusell/screens/dashboard/category-item.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';

class CategoryScreen extends StatelessWidget{
  final CategoryItem _categoryItem;

  CategoryScreen(this._categoryItem);



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(_categoryItem.category.name)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(_categoryItem.category.id),
          Text(_categoryItem.category.name)
        ],
      ),
    );
  }

}