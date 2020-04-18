import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/dashboard.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';
import 'package:kampusell/screens/side-menu/NavDrawer.dart';

import '../main.dart';

class DashboardState extends State<DashboardScreen> {
  Category category;
  Future<List<Product>> products;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    products = getDefaultProducts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(this),
      appBar: AppBar(titleSpacing: 0.0, automaticallyImplyLeading: false, title: AppBarContent(_scaffoldKey)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CategoriesList(),
          FutureBuilder(
              future: products,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return ProductsList(null, snapshot);
              })
        ],
      ),
      floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: FloatingActionButton.extended(
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
    this.category = category;
    setState(() {
      products = getProductsByCategory(category);
    });
  }



  Future<List<Product>> getDefaultProducts() async {
    var data;
    data = await http.get("https://kampusell-api.herokuapp.com/api/products");
    List<dynamic> jsonData = json.decode(data.body);
    List<Product> products = [];
    for (int i = 0; i < jsonData.length; i++) {
      List<String> imagePaths = jsonData[i]['imagePaths'].cast<String>();
      Product product = new Product.foo(
          jsonData[i]['id'].toString(),
          jsonData[i]['name'].toString(),
          jsonData[i]['description'].toString(),
          double.parse(jsonData[i]['price'].toString()),
          Category.fromJson(jsonData[i]['category']),
          imagePaths);
      products.add(product);
    }
    return products;
  }



  Future<List<Product>> getProductsByCategory(Category category) async {
    var data;
    if (category == null) {
      data = await http.get("https://kampusell-api.herokuapp.com/api/products/categoryId="+category.id);
    } else {
      data = await http.get("https://kampusell-api.herokuapp.com/api/products/categoryId="+category.id);
      List<dynamic> jsonData = json.decode(data.body);
      List<Product> products = [];
      for (int i = 0; i < jsonData.length; i++) {
        if (Category.fromJson(jsonData[i]['category']).name == category.name) {
          List<String> imagePaths = jsonData[i]['imagePaths'].cast<String>();
          Product product = new Product.foo(
              jsonData[i]['id'].toString(),
              jsonData[i]['name'].toString(),
              jsonData[i]['description'].toString(),
              double.parse(jsonData[i]['price'].toString()),
              Category.fromJson(jsonData[i]['category']),
              imagePaths);
          products.add(product);
        }
      }
      return products;
    }
  }

  _onSellProductBtnClick(BuildContext context) {
    Navigator.pushNamed(context, FillProductInfosRoute).then((value) {
      setState(() {
        if (category == null) {
          products = getDefaultProducts();
        } else {
          updateProducts(category);
        }
      });
    });
  }


}
