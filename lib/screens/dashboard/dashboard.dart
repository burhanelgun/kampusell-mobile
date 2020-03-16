


import 'package:flutter/material.dart';
import 'package:kampusell/screens/dashboard/app-bar-content.dart';
import 'package:kampusell/screens/dashboard/categories-list.dart';
import 'package:kampusell/screens/dashboard/products-list.dart';
import 'package:kampusell/states/_DashboardState.dart';

class DashboardScreen extends StatefulWidget{
  static DashboardState of(BuildContext context) => context.findAncestorStateOfType();

  @override
  DashboardState createState() => DashboardState();


}

