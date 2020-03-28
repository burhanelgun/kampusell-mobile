


import 'package:flutter/material.dart';
import 'package:kampusell/model/product.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';
import 'package:kampusell/states/_DashboardState.dart';
import 'package:kampusell/states/_FilterSettingsState.dart';

class FilterSettingsScreen extends StatefulWidget{
  static FilterSettingsState of(BuildContext context) => context.findAncestorStateOfType();

  FilterSettingsScreen();




  @override
  FilterSettingsState createState() => FilterSettingsState();


}

