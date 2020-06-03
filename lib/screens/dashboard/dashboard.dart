import 'package:flutter/material.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/states/_DashboardState.dart';

class DashboardScreen extends StatefulWidget {
  JwtModel jwtModel;

  DashboardScreen(this.jwtModel);

  static DashboardState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  DashboardState createState() => DashboardState(jwtModel);
}
