
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
        child:ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: CategoryItem(categories[index]),
                onTap: () => Scaffold
                    .of(context)
                    .showSnackBar(SnackBar(content: Text(index.toString()))),
              );
            },
            itemCount: 10)
    );


  }

}