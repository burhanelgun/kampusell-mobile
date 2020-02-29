
import 'package:flutter/cupertino.dart';
import 'package:kampusell/main.dart';
import 'package:kampusell/model/category.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/product-item.dart';

import 'category-item.dart';

class ProductsList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final List<Product> products = Product.fetchAll();
    return Expanded(
        child:ListView.separated(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: ProductItem(products[index]),
                onTap: () => _onProductTap(context,products[index].id),
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

  _onProductTap(BuildContext context, String id) {
      Navigator.pushNamed(context, ProductRoute,arguments:{"id":id} );
  }

}