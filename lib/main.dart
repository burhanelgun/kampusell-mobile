import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/screens/dashboard/dashboard.dart';
import 'package:kampusell/screens/fill-product-infos/fill-product-infos.dart';
import 'package:kampusell/screens/filter-settings/filter-settings.dart';
import 'package:kampusell/screens/my-messages/my-messages.dart';
import 'package:kampusell/screens/my-products/my-products.dart';
import 'package:kampusell/screens/my-profile/my-profile.dart';


import 'framework/bounce_scroll_behavior.dart';
import 'screens/product/product.dart';


const DashboardRoute = "/";
const ProductRoute = "/product";
const ChooseCategoryRoute = "/chooseCategory";
const FillProductInfosRoute = "/fillProductInfosRoute";
const FilterSettingsRoute = "/filterSettingsRoute";
const ProfileRoute = "/profileRoute";
const MyProductsRoute = "/myProductsRoute";
const MyMessagesRoute = "/myMessagesRoute";


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(),
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          pageTransitionsTheme: PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        )
      ),
      home:  ScrollConfiguration(
        behavior: BounceScrollBehavior(),
        child: DashboardScreen(),
      )
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
          screen = ProductScreen(arguments["productItem"]);
          break;
        case FillProductInfosRoute:
          screen = FillProductInfosScreen();
          break;
        case FilterSettingsRoute:
          screen = FilterSettingsScreen();
          break;
        case ProfileRoute:
          screen = MyProfileScreen();
          break;
        case MyProductsRoute:
          screen = MyProductsScreen();
          break;
        case MyMessagesRoute:
          screen = MyMessagesScreen();
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



