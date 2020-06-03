import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/screens/activation/activation.dart';
import 'package:kampusell/screens/dashboard/dashboard.dart';
import 'package:kampusell/screens/fill-product-infos/fill-product-infos.dart';
import 'package:kampusell/screens/filter-settings/filter-settings.dart';
import 'package:kampusell/screens/my-messages/my-messages.dart';
import 'package:kampusell/screens/my-products/my-products.dart';
import 'package:kampusell/screens/my-profile/my-profile.dart';
import 'package:kampusell/screens/product/product.dart';
import 'package:kampusell/screens/signin/sign_in.dart';
import 'package:kampusell/screens/signup/sign_up.dart';
import 'package:provider/provider.dart';

import 'framework/bounce_scroll_behavior.dart';
import 'screens/product/product.dart';

bool isLocal = true;

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
const ActivationRoute = "/activationRoute";

final storage = FlutterSecureStorage();

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => JwtModel(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<JwtModel>(builder: (context, jwtModel, child) {
      return MaterialApp(
          onGenerateRoute: _routes(jwtModel),
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              pageTransitionsTheme: PageTransitionsTheme(
                builders: <TargetPlatform, PageTransitionsBuilder>{
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              )),
          home: ScrollConfiguration(
            behavior: BounceScrollBehavior(),
            child: DashboardScreen(jwtModel),
          ));
    });
  }

  RouteFactory _routes(JwtModel jwtModel) {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case DashboardRoute:
          screen = DashboardScreen(jwtModel);
          break;
        case ProductRoute:
          screen = ProductScreen(arguments["product"]);
          break;
        case FillProductInfosRoute:
          screen = FillProductInfosScreen(arguments["jwtModel"]);
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
        case SignInRoute:
          screen = SignInScreen();
          break;
        case SignUpRoute:
          screen = SignUpScreen();
          break;
        case ActivationRoute:
          screen = ActivationScreen(
              jwtModel, arguments["signUpForm"], arguments["activationCode"]);
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
