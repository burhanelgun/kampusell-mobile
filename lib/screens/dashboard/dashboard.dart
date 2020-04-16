import 'package:flutter/material.dart';
import 'package:kampusell/states/_DashboardState.dart';

class DashboardScreen extends StatefulWidget {
  static DashboardState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  DashboardState createState() => DashboardState();
}
