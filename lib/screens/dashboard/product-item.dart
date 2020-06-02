import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';

class ProductItem extends StatelessWidget {
  Product product;

  ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24))),
              child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: product.imagePaths == null
                          ? null
                          : new DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(product.imagePaths[0])))),
            ),
            title: Text(
              product.name,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Row(
              children: <Widget>[
                Text(
                  product.description,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
      ),
    );
  }





}
