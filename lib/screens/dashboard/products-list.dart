import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/dashboard/product-item.dart';

class ProductsList extends StatelessWidget {
  Category _category;
  List<Product> snapshot;
  JwtModel _jwtModel;
  ScrollController scrollController;
  ProductsList(this._category, this.snapshot, this._jwtModel, this.scrollController);

  @override
  Widget build(BuildContext context) {
    print("BUILD İŞLEMİ");
    if (snapshot == null) {
      return Container(
        child: Center(
          child: Text("Yükleniyor..."),
        ),
      );
    } else {
      List<Product> products = snapshot;

      return Expanded(
          child: ListView.builder(
            controller: scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshot.length,
        itemBuilder: (context, index) {
         // ProductItem productItem = new ProductItem(snapshot[snapshot.length-index-1],_jwtModel);
          ProductItem productItem = new ProductItem(snapshot[index],_jwtModel);

          return productItem;
        },
      ));
    }
  }
  void _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter < 500) {
      print("scroll calisti");
    }
  }
}
