import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kampusell/providers/jwt_model.dart';
import 'package:kampusell/states/_FillProductInfosState.dart';

class FillProductInfosScreen extends StatefulWidget {
  JwtModel jwtModel;

  FillProductInfosScreen(this.jwtModel);

  static FillProductInfosState of(BuildContext context) =>
      context.findAncestorStateOfType();

  @override
  FillProductInfosState createState() => FillProductInfosState(jwtModel);
}
