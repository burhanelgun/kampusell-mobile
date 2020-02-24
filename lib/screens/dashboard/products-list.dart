
import 'package:flutter/cupertino.dart';
import 'package:kampusell/model/category.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/product-item.dart';

import 'category-item.dart';

class ProductsList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final List<Product> categories = Product.fetchAll();
    return Expanded(
        child:ListView.separated(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title:ProductItem(categories[index]),
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