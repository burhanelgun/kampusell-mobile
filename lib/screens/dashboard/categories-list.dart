
import 'package:flutter/cupertino.dart';
import 'package:kampusell/model/category.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'category-item.dart';
import 'dashboard.dart';

class CategoriesList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final List<Category> categories = Category.fetchAll();
    return ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 15.0,
          maxHeight: 70.0,
        ),
        child:ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              CategoryItem clickedCategoryItem = new CategoryItem(categories[index]);
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: clickedCategoryItem,
                onTap: () => _onCategoryTap(context,clickedCategoryItem),
              );
            },
            itemCount: 10)
    );


  }

  _onCategoryTap(BuildContext context, CategoryItem categoryItem) {
    DashboardScreen.of(context).updateProducts(categoryItem.category);
    //DashboardScreen.of(context).setState();
    //Navigator.pushNamed(context, CategoryRoute,arguments:{"categoryItem":categoryItem} );
  }


}