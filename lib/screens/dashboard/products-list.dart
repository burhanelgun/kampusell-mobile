import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/main.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/product-item.dart';

class ProductsList extends StatelessWidget {
  Category _category;
  AsyncSnapshot snapshot;

  ProductsList(this._category, this.snapshot);

  @override
  Widget build(BuildContext context) {
    if (snapshot.data == null) {
      return Container(
        child: Center(
          child: Text("Loading..."),
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
          ProductItem productItem = new ProductItem(snapshot.data[index]);

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: productItem,
            onTap: () => _onProductTap(context, productItem),
          );
        },

      ));
    }
  }




  _onProductTap(BuildContext context, ProductItem productItem) {
    print("************************************************");
    print(productItem.product.id);
    print(productItem.product.name);
    print(productItem.product.imagePaths);
    print(productItem.product.price);
    print(productItem.product.description);
    print(productItem.product.category.name);
    print(productItem.product.student.username);
    print("************************************************");

    Navigator.pushNamed(context, ProductRoute,
        arguments: {"productItem": productItem});
  }
}
