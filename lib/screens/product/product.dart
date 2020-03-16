




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';

class ProductScreen extends StatelessWidget{
  final Product _product;

  ProductScreen(this._product);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(_product.name)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(_product.id),
          Text(_product.name),
          Text(_product.category.name),
          Text(_product.description),
          Text(_product.owner.name),
          Text(_product.price.toString()),
          new Container(
              width: 50.0,
              height: 50.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage(
                          _product.photoPaths[0])
                  )
              )
          )
        ],
      ),


    );
  }

}