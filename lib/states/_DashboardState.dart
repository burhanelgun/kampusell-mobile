import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kampusell/model/category.dart';
import 'package:kampusell/model/product-filter.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/model/student.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/dashboard.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';
import 'package:kampusell/screens/side-menu/NavDrawer.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class DashboardState extends State<DashboardScreen> {
  Category category;
  Future<List<Product>> products;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController searchTextController = TextEditingController();
  JwtModel jwtModel;
  int _filter=0;

  DashboardState(this.jwtModel);

  @override
  void initState() {
    super.initState();
    products = getDefaultProducts();
    searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final jwtModel = Provider.of<JwtModel>(context);

    if (this.jwtModel != jwtModel) {
      this.jwtModel = jwtModel;
      Future.microtask(() => jwtModel.read());
    }
   if(_filter!=1){
      products = getDefaultProducts();
      _filter=0;
    }
    searchTextController.addListener(() {
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(this, jwtModel),
      appBar: AppBar(
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          title: AppBarContent(
              _scaffoldKey, searchTextController, this, jwtModel)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CategoriesList(jwtModel, _scaffoldKey),
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
            onPressed: () => _onSellProductBtnClick(context, jwtModel),
            label: Text('Eşyalarını Sat'),
            icon: Icon(Icons.photo_camera),
            backgroundColor: Colors.pink,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void updateProducts(Category category) {
    this.category = category;
    setState(() {
      products = getProductsByCategory(category);
    });
  }

  void updateProductsDefault() {
    this.category = category;
    setState(() {
      products = getDefaultProducts();
    });
  }

  Future<List<Product>> getDefaultProducts() async {
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
      Product product = new Product(
        jsonData[i]['id'].toString(),
        jsonData[i]['name'].toString(),
        jsonData[i]['description'].toString(),
        double.parse(jsonData[i]['price'].toString()),
        imagePaths,
        Student.fromJson(jsonData[i]['student']),
        Category.fromJson(jsonData[i]['category']),
      );
      products.add(product);
    }
    return products;
  }

  Future<List<Product>> getProductsByCategory(Category category) async {
    var data;

    if (isLocal) {
      data = await http.get(
          "http://10.0.2.2:8080/api/products/categoryName=" + category.name,
          headers: {"Authorization": jwtModel.getJwt()});
    } else {
      data = await http.get(
          "https://kampusell-api.herokuapp.com/api/products/categoryName=" +
              category.name,
          headers: {"Authorization": jwtModel.getJwt()});
    }

    List<dynamic> jsonData = json.decode(data.body);
    List<Product> products = [];
    for (int i = 0; i < jsonData.length; i++) {
      if (Category.fromJson(jsonData[i]['category']).name == category.name) {
        List<String> imagePaths = jsonData[i]['imagePaths'].cast<String>();
        Product product = new Product(
          jsonData[i]['id'].toString(),
          jsonData[i]['name'].toString(),
          jsonData[i]['description'].toString(),
          double.parse(jsonData[i]['price'].toString()),
          imagePaths,
          Student.fromJson(jsonData[i]['student']),
          Category.fromJson(jsonData[i]['category']),
        );
        products.add(product);
      }
    }
    return products;
  }

  _onSellProductBtnClick(BuildContext context, JwtModel jwtModel) {
    //if user  signed in
    if (jwtModel.getJwt().length > 0) {
      Navigator.pushNamed(context, FillProductInfosRoute,
          arguments: {"jwtModel": jwtModel}).then((value) {
        setState(() {
          if (category == null) {
            products = getDefaultProducts();
          } else {
            updateProducts(category);
          }
        });
      });
    } else {
      Navigator.pushNamed(context, SignInRoute).then((value) async {
        //read "value" value for checking is user signed in
        //after the sign in
        bool isUserSignIn = value;
        if (isUserSignIn) {
          //change default user icon with the user image in app bar
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Giriş Yapıldı"),
          ));
          updateProductsDefault();
        } else {
          //User couldn't sign in but user can go the dashboard
        }
      });
    }
  }

  refresh() {
    setState(() {});
  }

  void search() {
    setState(() {
      products = getSearchedProducts(searchTextController.text);
    });
  }

  void filter(ProductFilter productFilter) {
    print("filtreleme işlemi başladı:");
    setState(() {
      products = getFilteredProducts(productFilter);
      print(products);
      _filter=1;
    });
  }

  Future<List<Product>> getSearchedProducts(String searchText) async {
    var data;

    if (isLocal) {
      data = await http.get(
          "http://10.0.2.2:8080/api/products/searchText=" + searchText,
          headers: {"Authorization": jwtModel.getJwt()});
    } else {
      data = await http.get(
          "https://kampusell-api.herokuapp.com/api/products/searchText=" +
              searchText,
          headers: {"Authorization": jwtModel.getJwt()});
    }

    List<dynamic> jsonData = json.decode(data.body);
    List<Product> products = [];
    for (int i = 0; i < jsonData.length; i++) {
      List<String> imagePaths = jsonData[i]['imagePaths'].cast<String>();
      Product product = new Product(
        jsonData[i]['id'].toString(),
        jsonData[i]['name'].toString(),
        jsonData[i]['description'].toString(),
        double.parse(jsonData[i]['price'].toString()),
        imagePaths,
        Student.fromJson(jsonData[i]['student']),
        Category.fromJson(jsonData[i]['category']),
      );
      products.add(product);
    }
    return products;
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
      Product product = new Product(
        jsonData[i]['id'].toString(),
        jsonData[i]['name'].toString(),
        jsonData[i]['description'].toString(),
        double.parse(jsonData[i]['price'].toString()),
        imagePaths,
        Student.fromJson(jsonData[i]['student']),
        Category.fromJson(jsonData[i]['category']),
      );
      products.add(product);
    }
    return products;
  }
}
