
import 'package:flutter/cupertino.dart';
import 'package:kampusell/main.dart';
import 'package:kampusell/model/category.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/dashboard.dart';
import 'package:kampusell/screens/dashboard/product-item.dart';

import 'category-item.dart';

class ProductsList extends StatelessWidget{
  Category _category;
  AsyncSnapshot snapshot;

  ProductsList(this._category,this.snapshot);

  @override
  Widget build(BuildContext context) {
    //final List<Product> products = Product.fetchAll();
    if(snapshot.data==null){
      return Container(
        child: Center(
          child: Text("Loading..."),
        ),
      );
    }
    else{
      return Expanded(
          child:ListView.separated(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              ProductItem productItem = new ProductItem(snapshot.data[index]);
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: productItem,
                onTap: () => _onProductTap(context,productItem),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.black,
              );
            },
          )
      );
    }


  }

  _onProductTap(BuildContext context, ProductItem productItem) {
      Navigator.pushNamed(context, ProductRoute,arguments:{"productItem":productItem} );
  }

}