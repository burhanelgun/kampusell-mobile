import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/screens/dashboard/category-item.dart';
import 'package:kampusell/states/_FillProductInfosState.dart';


class FillProductInfosScreen extends StatefulWidget {

  final CategoryItem _categoryItem;

  FillProductInfosScreen(this._categoryItem);


  static FillProductInfosState of(BuildContext context) => context.findAncestorStateOfType();

  @override
  FillProductInfosState createState() => FillProductInfosState(this._categoryItem);

}