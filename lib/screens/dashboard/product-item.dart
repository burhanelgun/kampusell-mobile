import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';

import '../../main.dart';

class ProductItem extends StatelessWidget {
  Product product;
  String username;

  ProductItem(this.product,this.username);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.black54),
        child: ListTile(
            onTap: () => _onProductTap(context),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 15.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.white30))),
              child: Container(
                  width: 80.0,
                  height: 80.0,
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    product.description,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0)),
      ),
    );
  }

  _onProductTap(BuildContext context) {
    Navigator.pushNamed(context, ProductRoute, arguments: {"product": product,
      "username": username});
  }
}
