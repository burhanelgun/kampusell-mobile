import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/dashboard/product-item.dart';

class ProductsList extends StatelessWidget {
  Category _category;
  AsyncSnapshot snapshot;
  JwtModel _jwtModel;

  ProductsList(this._category, this.snapshot, this._jwtModel);

  @override
  Widget build(BuildContext context) {
    if (snapshot.data == null) {
      return Container(
        child: Center(
          child: Text("Yükleniyor..."),
        ),
      );
    } else {
      List<Product> products = snapshot.data;

      return Expanded(
          child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          ProductItem productItem = new ProductItem(snapshot.data[snapshot.data.length-index-1],_jwtModel);

          return productItem;
        },
      ));
    }
  }
}
