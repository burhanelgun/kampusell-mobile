import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/states/_MyProductsState.dart';

class MyProductsScreen extends StatefulWidget {

  JwtModel jwtModel;
  static MyProductsState of(BuildContext context) =>
      context.findAncestorStateOfType();

  MyProductsScreen(this.jwtModel);

  @override
  MyProductsState createState() => MyProductsState(jwtModel);
}