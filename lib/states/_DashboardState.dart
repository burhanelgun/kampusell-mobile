import 'dart:async';
import 'dart:convert';

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
import 'package:kampusell/screens/side-menu/NavDrawer.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class DashboardState extends State<DashboardScreen> {
  Category category;
  ScrollController controller;
  int status = 0;
  int incrementVal=6;
  int start=0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController searchTextController = TextEditingController();
  JwtModel jwtModel;
  List<Product> _products;
  int _filter=0;
  String username;

  DashboardState(this.jwtModel);

  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
    start=0;
    _products=null;
    getDefaultProducts();
    searchTextController.addListener(() {
      setState(() {});
    });
  }
  void _scrollListener() {
    print(controller.position.extentAfter);
    if (controller.position.extentAfter < 1 && status==0) {
      setState(() async {
        print("GETDEFAULTPRODUCTS");
        status = 1;
        start=start+1;
        getDefaultProducts();

      });
    }
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

      getDefaultProducts();
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
          ProductsList(null, _products,jwtModel,controller)

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
      getProductsByCategory(category);
    });
  }

  void updateProductsDefault() {
    this.category = category;
    setState(() {
      getDefaultProducts();
    });
  }

  void getDefaultProducts() async {
    var data;
    if (isLocal) {
      data = await http.get("http://10.0.2.2:8080/api/products/begin="+start.toString()+"/"+"end="+incrementVal.toString(),
          headers: {"Authorization": jwtModel.getJwt()});
    } else {
      data = await http.get("https://kampusell-api.herokuapp.com/api/products/begin="+start.toString()+"/"+"end="+incrementVal.toString(),
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

    //pagination technique
    setState(() {
      print("PRODUCTs-PRODUCTs");
      print(products);
      if(_products==null){
        _products=List();
      }
      int flag=0;
      for(int i = 0; i<_products.length;i++){
        if(_products[i].name==products[0].name){
          flag=1;
        }
      }
      if(flag==0){
        _products.addAll(products);
      }

      if(products.length>=incrementVal){
        status=0;
      }
    });

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
    //change with pagination technique
    setState(() {
      _products=products;
    });
  }

  _onSellProductBtnClick(BuildContext context, JwtModel jwtModel) {
    //if user  signed in
    if (jwtModel.getJwt().length > 0) {
      Navigator.pushNamed(context, FillProductInfosRoute,
          arguments: {"jwtModel": jwtModel}).then((value) {
        setState(() {
          if (category == null) {
            _products=null;
            start=0;
            getDefaultProducts();
          } else {
            updateProducts(category);
          }
        });
      });
    } else {
      Navigator.pushNamed(context, SignInRoute).then((value) async {
        //read "value" value for checking is user signed in
        //after the sign in

        Map<String, dynamic> popReturn = value;


        if (popReturn["isSignIn"]) {
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
      getSearchedProducts(searchTextController.text);
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
    });  }

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
    //change with pagination technique
    setState(() {
      _products=products;
    });  }

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
    //change with pagination technique
    setState(() {
      _products=products;
    });  }


}
