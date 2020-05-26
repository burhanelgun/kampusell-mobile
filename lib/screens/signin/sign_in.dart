import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/states/_FillProductInfosState.dart';
import 'package:kampusell/states/_SignInState.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen();

  static FillProductInfosState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  SignInState createState() => SignInState();
}
