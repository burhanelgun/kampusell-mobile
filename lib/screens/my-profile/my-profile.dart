import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/states/_MyProfileScreenState.dart';


class MyProfileScreen extends StatefulWidget {
  JwtModel jwtModel;

  MyProfileScreen(this.jwtModel);

  static MyProfileState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  MyProfileState createState() => MyProfileState(jwtModel);
}








