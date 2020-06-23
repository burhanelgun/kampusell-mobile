import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/states/_MyMessagesState.dart';

class MyMessagesScreen extends StatefulWidget {
  JwtModel jwtModel;

  MyMessagesScreen(this.jwtModel);

  static MyMessagesState of(BuildContext context) =>
      context.findAncestorStateOfType();


  @override
  MyMessagesState createState() => MyMessagesState(this.jwtModel);
}
