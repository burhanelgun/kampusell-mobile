import 'package:flutter/cupertino.dart';
import 'package:kampusell/model/category.dart';

class CategoryItem extends StatelessWidget{

  Category category;

  CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        category.imagePath)
                )
            ))

      ],
    );
  }

}