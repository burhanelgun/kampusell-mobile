




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';

class ProductScreen extends StatelessWidget{
  final String _productID;

  ProductScreen(this._productID);

  @override
  Widget build(BuildContext context) {

    final Product product = Product.fetchByID(_productID);

    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(product.name)
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(product.id),
          Text(product.name),
          Text(product.category.name),
          Text(product.description),
          Text(product.owner.name),
          Text(product.price.toString()),
          new Container(
              width: 50.0,
              height: 50.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage(
                          product.photoPaths[0])
                  )
              )
          )
        ],
      ),


    );
  }

}