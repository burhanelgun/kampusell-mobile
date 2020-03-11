import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/dashboard.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class DashboardState extends State<DashboardScreen> {

  bool _isFavorited = true;
  int _favoriteCount = 41;

  Future<List<Product>> _getProducts() async{
    print("DENEME1:");

    var data = await http.get("https://kampusell-api.herokuapp.com/api/products");
    List<dynamic> jsonData= json.decode(data.body);
    print("DENEME2:");

    List<Product> products = [];
    print("DENEME3:");
    print(jsonData);
    //Product(this.id,this.name,this.description,this.price,this.photoPaths,this.owner,this.category);
    print("DENEME55:");
    print("DENEME56:");

    for(int i=0;i<jsonData.length;i++){
      print(jsonData[i]['id']);
      print(jsonData[i]['name']);
      print(jsonData[i]['description']);
      print(jsonData[i]['price']);
      Product product = new Product.foo(jsonData[i]['id'].toString(),jsonData[i]['name'].toString(),jsonData[i]['description'].toString(),double.parse(jsonData[i]['price'].toString()));
      print("DENEME58:");
      products.add(product);
    }
    print("DENEME59:");

    print(products);

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0.0,
          title: AppBarContent()
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CategoriesList(),
          FutureBuilder(
            future: _getProducts(),
            builder: (BuildContext context,AsyncSnapshot snapshot){
              return ProductsList(null,snapshot);
            }


          )


        ],
      ),


    );
  }


  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

}