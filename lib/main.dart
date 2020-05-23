import 'package:flutter/material.dart';
import 'package:kampusell/model/category.dart';
import 'package:kampusell/screens/dashboard/dashboard.dart';
import 'package:kampusell/screens/fill-product-infos/fill-product-infos.dart';
import 'package:kampusell/screens/filter-settings/filter-settings.dart';
import 'package:kampusell/screens/my-messages/my-messages.dart';
import 'package:kampusell/screens/my-products/my-products.dart';
import 'package:kampusell/screens/my-profile/my-profile.dart';
import 'package:kampusell/screens/signin/sign_in.dart';
import 'package:kampusell/screens/signup/sign_up.dart';


import 'framework/bounce_scroll_behavior.dart';
import 'screens/product/product.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

bool isLocal= true;

const DashboardRoute = "/";
const ProductRoute = "/product";
const ChooseCategoryRoute = "/chooseCategory";
const FillProductInfosRoute = "/fillProductInfosRoute";
const FilterSettingsRoute = "/filterSettingsRoute";
const ProfileRoute = "/profileRoute";
const MyProductsRoute = "/myProductsRoute";
const MyMessagesRoute = "/myMessagesRoute";
const SignInRoute = "/signInRoute";
const SignUpRoute = "/signUpRoute";

final storage = FlutterSecureStorage();


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

   String jwt;


  Future<String> jwtOrEmpty() async {
    var jwt = await storage.read(key: "jwt");
    if(jwt == null) return "";
    return jwt;
  }

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
        home: FutureBuilder(
            future: jwtOrEmpty(),
            builder: (context, snapshot) {
                if(snapshot.data != "" && snapshot.data != null) {
                  print("new::"+ snapshot.data.toString());
                  jwt = snapshot.data;
                  return ScrollConfiguration(
                    behavior: BounceScrollBehavior(),
                    child: DashboardScreen(jwt),
                  );
                }
                else{
                  return DashboardScreen(jwt);
                }


            }
        )





        );

  }

  RouteFactory _routes() {
    return (settings){
      final Map<String,dynamic> arguments = settings.arguments;
      Widget screen;
      switch(settings.name){
        case DashboardRoute:
          screen = DashboardScreen(jwt);
          break;
        case ProductRoute:
          screen = ProductScreen(arguments["productItem"]);
          break;
        case FillProductInfosRoute:
          screen = FillProductInfosScreen(jwt);
          break;
        case FilterSettingsRoute:
          screen = FilterSettingsScreen(jwt);
          break;
        case ProfileRoute:
          screen = MyProfileScreen(jwt);
          break;
        case MyProductsRoute:
          screen = MyProductsScreen(jwt);
          break;
        case MyMessagesRoute:
          screen = MyMessagesScreen(jwt);
          break;
        case SignInRoute:
          screen = SignInScreen(jwt);
          break;
        case SignUpRoute:
          screen = SignUpScreen(jwt);
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



