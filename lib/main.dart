import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/screens/category/category.dart';
import 'package:kampusell/screens/dashboard/dashboard.dart';

import 'screens/product/product.dart';


const DashboardRoute = "/";
const ProductRoute = "/product";
const CategoryRoute = "/category";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: DashboardScreen()
    );
  }

  RouteFactory _routes() {
    return (settings){
      final Map<String,dynamic> arguments = settings.arguments;
      Widget screen;
      switch(settings.name){
        case DashboardRoute:
          screen = DashboardScreen();
          break;
        case ProductRoute:
          screen = ProductScreen(arguments["product"]);
          break;
        case CategoryRoute:
          screen = CategoryScreen(arguments["category"]);
          break;
        default:
          return null;
      }
      return MaterialPageRoute(
          builder: (BuildContext context) => screen,
          settings: RouteSettings(name: settings.name, isInitialRoute: true),


      );
    };
  }
}

