




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/main.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/category-item.dart';
import 'package:kampusell/screens/dashboard/product-item.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';

class FillProductInfosScreen extends StatelessWidget{
  final CategoryItem _categoryItem;

  FillProductInfosScreen(this._categoryItem);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(_categoryItem.category.name+" kategorisi için ürün bilgilerini giriniz")
      ),
      body:Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ürün Adı'
              ),

            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ürün Açıklaması'
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ürün Fiyatı'
              ),
            ),

          ],
        ) ,

      ),



    );
  }

}