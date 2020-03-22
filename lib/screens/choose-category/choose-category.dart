




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/main.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/category-item.dart';
import 'package:kampusell/screens/dashboard/product-item.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';

class ChooseCategoryScreen extends StatelessWidget{
  final List<Category> categories = Category.fetchAll();


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          title: Text("Kategori Seç")
      ),
      body: GridView.count(
        crossAxisCount: 2,

        //first way for mapping list
        children:categories
          .map((Category category) {
            CategoryItem clickedCategoryItem = new CategoryItem(category);
            return GestureDetector(
              child: Card(
                  child: Container(
                    child: clickedCategoryItem,
                    alignment: Alignment.center,
                    color: Colors.red,
                  ),

              ),
              onTap: () => _onCategoryTap(context,clickedCategoryItem),
            );
          }).toList()


        //second way for mapping list
        /*children:categories
            .map(
                (category) => Text(category.name),
        ).toList(),*/
      ),


    );
  }

  _onCategoryTap(BuildContext context, CategoryItem categoryItem) {
    Navigator.pushNamed(context, FillProductInfosRoute, arguments:{"categoryItem":categoryItem});

  }

}