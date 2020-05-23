import 'package:flutter/material.dart';
import 'package:kampusell/states/_DashboardState.dart';

class DashboardScreen extends StatefulWidget {
  String jwt;

  DashboardScreen(this.jwt);

  static DashboardState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  DashboardState createState() => DashboardState(jwt);
}
