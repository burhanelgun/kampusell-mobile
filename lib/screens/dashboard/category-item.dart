import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';

class CategoryItem extends StatelessWidget{

  Category category;

  CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {

    return Container(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(category.name,
                textScaleFactor: 1.0),
            new Container(
                width: 50.0,
                height: 50.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new AssetImage(
                          'assets/images/emlak.png')
                    )
                ))
          ],
      )
    );
  }

}