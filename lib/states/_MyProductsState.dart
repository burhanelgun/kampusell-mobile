import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/photo-value.dart';
import 'package:kampusell/model/product-filter.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/model/signin-form.dart';
import 'package:kampusell/model/student.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/dashboard.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';
import 'package:kampusell/screens/my-products/my-products.dart';
import 'package:kampusell/screens/side-menu/NavDrawer.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class MyProductsState extends State<MyProductsScreen> {
  Category category;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController searchTextController = TextEditingController();
  JwtModel jwtModel;
  List<Product> _products;
  int _filter=0;
  String username;

  MyProductsState(this.jwtModel);

  @override
  void initState() {
    super.initState();
    print("denemelik");
    search();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Satıştaki Ürünlerim"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ProductsList(null, _products,jwtModel,new ScrollController())

        ],
      ),

    );
  }




  void getDefaultProducts() async {
    var data;
    if (isLocal) {
      data = await http.get("http://10.0.2.2:8080/api/products",
          headers: {"Authorization": jwtModel.getJwt()});
    } else {
      data = await http.get("https://kampusell-api.herokuapp.com/api/products",
          headers: {"Authorization": jwtModel.getJwt()});
    }
    List<dynamic> jsonData = json.decode(data.body);
    List<Product> products = [];
    for (int i = 0; i < jsonData.length; i++) {
      List<String> imagePaths = jsonData[i]['imagePaths'].cast<String>();
      List<String> texts = jsonData[i]['texts'].cast<String>();
      List<String> labels = jsonData[i]['labels'].cast<String>();

      Product product = new Product(
        jsonData[i]['id'].toString(),
        jsonData[i]['name'].toString(),
        jsonData[i]['description'].toString(),
        double.parse(jsonData[i]['price'].toString()),
        imagePaths,
        Student.fromJson(jsonData[i]['student']),
        Category.fromJson(jsonData[i]['category']),
        texts,
        labels
      );
      products.add(product);
    }
  }




  refresh() {
    setState(() {});
  }

  void search() {
    setState(() {
      getProductsByUsername(jwtModel.getUsername());
    });
  }

  void filter(ProductFilter productFilter) {


    if(productFilter!=null){
      print("filtreleme işlemi başladı:");
      setState(() {
        getFilteredProducts(productFilter);
        print(_products);
        _filter=1;
      });
    }
  }

  Future<List<Product>> getProductsByUsername(String username) async {
    var data;

    if (isLocal) {
      data = await http.get(
          "http://10.0.2.2:8080/api/products/username=" + username,
          headers: {"Authorization": jwtModel.getJwt()});
    } else {
      data = await http.get(
          "https://kampusell-api.herokuapp.com/api/products/username=" +
              username,
          headers: {"Authorization": jwtModel.getJwt()});
    }

    List<dynamic> jsonData = json.decode(data.body);
    List<Product> products = [];
    for (int i = 0; i < jsonData.length; i++) {
      List<String> imagePaths = jsonData[i]['imagePaths'].cast<String>();
      List<String> texts = jsonData[i]['texts'].cast<String>();
      List<String> labels = jsonData[i]['labels'].cast<String>();

      Product product = new Product(
        jsonData[i]['id'].toString(),
        jsonData[i]['name'].toString(),
        jsonData[i]['description'].toString(),
        double.parse(jsonData[i]['price'].toString()),
        imagePaths,
        Student.fromJson(jsonData[i]['student']),
        Category.fromJson(jsonData[i]['category']),
        texts,
          labels

      );
      products.add(product);
    }
    //change with pagination technique
    setState(() {
      _products=products;
    });
  }

  Future<List<Product>> getFilteredProducts(ProductFilter productFilter) async {
    var data;


    if (isLocal) {
      data = await http.post(
        'http://10.0.2.2:8080/api/products/filter',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": jwtModel.getJwt()
        },
        body: jsonEncode(productFilter),
      );
    } else {
      data = await http.post(
        'https://kampusell-api.herokuapp.com/api/products/filter',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": jwtModel.getJwt()
        },
        body: jsonEncode(productFilter),
      );
    }

    List<dynamic> jsonData = json.decode(data.body);
    List<Product> products = [];
    for (int i = 0; i < jsonData.length; i++) {
      List<String> imagePaths = jsonData[i]['imagePaths'].cast<String>();
      List<String> texts = jsonData[i]['texts'].cast<String>();
      List<String> labels = jsonData[i]['labels'].cast<String>();

      Product product = new Product(
        jsonData[i]['id'].toString(),
        jsonData[i]['name'].toString(),
        jsonData[i]['description'].toString(),
        double.parse(jsonData[i]['price'].toString()),
        imagePaths,
        Student.fromJson(jsonData[i]['student']),
        Category.fromJson(jsonData[i]['category']),
        texts,
        labels
      );
      products.add(product);
    }
    return products;
  }

  void filterWithPhoto(PhotoValue photoValue) {
    if(photoValue!=null){
      print("filtreleme işlemi başladı:");
      setState(() {
        getSimilarProducts(photoValue);
        print(_products);
        _filter=1;
      });
    }
  }

  Future<List<Product>> getSimilarProducts(PhotoValue photoValue) async {
    var data;
    if (isLocal) {
      data = await http.post(
        'http://10.0.2.2:8080/api/products/findWithPhoto',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": jwtModel.getJwt()
        },
        body: jsonEncode(photoValue),
      );
    } else {
      data = await http.post(
        'https://kampusell-api.herokuapp.com/api/products/findWithPhoto',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": jwtModel.getJwt()
        },
        body: jsonEncode(photoValue),
      );
    }

    List<dynamic> jsonData = json.decode(data.body);
    List<Product> products = [];
    for (int i = 0; i < jsonData.length; i++) {
      List<String> imagePaths = jsonData[i]['imagePaths'].cast<String>();
      List<String> texts = jsonData[i]['texts'].cast<String>();
      List<String> labels = jsonData[i]['labels'].cast<String>();

      Product product = new Product(
        jsonData[i]['id'].toString(),
        jsonData[i]['name'].toString(),
        jsonData[i]['description'].toString(),
        double.parse(jsonData[i]['price'].toString()),
        imagePaths,
        Student.fromJson(jsonData[i]['student']),
        Category.fromJson(jsonData[i]['category']),
        texts,
        labels
      );
      products.add(product);
    }
    return products;
  }


}
