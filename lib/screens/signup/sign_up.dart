import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/states/_FillProductInfosState.dart';
import 'package:kampusell/states/_SignInState.dart';
import 'package:kampusell/states/_SignUpState.dart';

class SignUpScreen extends StatefulWidget {
  String jwt;
  SignUpScreen(this.jwt);

  static FillProductInfosState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  SignUpState createState() => SignUpState(jwt);
}
