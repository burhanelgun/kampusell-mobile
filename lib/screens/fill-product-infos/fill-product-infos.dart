import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/states/_FillProductInfosState.dart';

class FillProductInfosScreen extends StatefulWidget {
  String jwt;
  FillProductInfosScreen(this.jwt);

  static FillProductInfosState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  FillProductInfosState createState() => FillProductInfosState(jwt);
}
