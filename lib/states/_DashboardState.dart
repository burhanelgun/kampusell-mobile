import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/dashboard.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';


class DashboardState extends State<DashboardScreen> {

  bool _isFavorited = true;
  int _favoriteCount = 41;
  Category category;
  Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    print("initState");
    products=getDefaultProducts();
  }

  Future<List<Product>> getDefaultProducts() async{
    var data;
    print("11111");
    data = await http.get("https://kampusell-api.herokuapp.com/api/products");
    print("1515151515151515");
    List<dynamic> jsonData= json.decode(data.body);
    print("222222222");


    List<Product> products = [];
    for(int i=0;i<jsonData.length;i++){
      print("4444444444");

      Product product = new Product.foo(jsonData[i]['id'].toString(),jsonData[i]['name'].toString(),jsonData[i]['description'].toString(),double.parse(jsonData[i]['price'].toString()),Category.fromJson(jsonData[i]['category']));
      print("5555555555");

      products.add(product);
      print("6666666666");

    }
    print("777777777777");

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
            future: products,
            builder: (BuildContext context,AsyncSnapshot snapshot){
              return ProductsList(null,snapshot);
            }


          )


        ],
      ),
      floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child:FloatingActionButton.extended(
            onPressed: () => _onSellProductBtnClick(context),
            label: Text('Eşyalarını Sat'),
            icon: Icon(Icons.photo_camera),
              backgroundColor: Colors.pink,
            )
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


    );
  }



  void updateProducts(Category category) {

    setState(() {
      products=getProductsByCategory(category);
    });
  }

  Future<List<Product>> getProductsByCategory(Category category) async{
    var data;
    if(category==null){
      print("null2");
      data = await http.get("https://kampusell-api.herokuapp.com/api/products");
    }
    else {
      data = await http.get("https://kampusell-api.herokuapp.com/api/products");

      List<dynamic> jsonData= json.decode(data.body);
      List<Product> products = [];
      for(int i=0;i<jsonData.length;i++){
        if(Category.fromJson(jsonData[i]['category']).name==category.name){
          Product product = new Product.foo(jsonData[i]['id'].toString(),jsonData[i]['name'].toString(),jsonData[i]['description'].toString(),double.parse(jsonData[i]['price'].toString()),Category.fromJson(jsonData[i]['category']));
          products.add(product);
        }

      }


      return products;
    }


  }

  _onSellProductBtnClick(BuildContext context) {

    Navigator.pushNamed(context, ChooseCategoryRoute );


  }


}