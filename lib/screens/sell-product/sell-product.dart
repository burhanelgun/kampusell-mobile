




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/product-item.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';

class SellProductScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          title: Text("Eşyanı Sat")
      ),
      body: Column()

    );
  }

}