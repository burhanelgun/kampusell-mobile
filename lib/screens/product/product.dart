




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/product-item.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';

class ProductScreen extends StatelessWidget{
  final ProductItem _productItem;

  ProductScreen(this._productItem);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(_productItem.product.name)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(_productItem.product.id),
          Text(_productItem.product.name),
          Text(_productItem.product.category.name),
          Text(_productItem.product.description),
          Text(_productItem.product.student.name),
          Text(_productItem.product.price.toString()),
          new Container(
              width: 50.0,
              height: 50.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage(
                          _productItem.product.imagePaths[0])
                  )
              )
          )
        ],
      ),


    );
  }

}