import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';

class ProductItem extends StatelessWidget {
  Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: Row(
          children: <Widget>[
            new Container(
                width: 50.0,
                height: 50.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new AssetImage(product.imagePaths[0])))),
            Expanded(
              child: Column(
                children: <Widget>[
                  new Text(product.name, textScaleFactor: 1.0),
                  new Text(product.category.name, textScaleFactor: 1.0),
                  new Text(product.price.toString(), textScaleFactor: 1.0),
                  new Text(product.description, textScaleFactor: 1.0),
                ],
              ),
            ),
          ],
        ));
  }
}
