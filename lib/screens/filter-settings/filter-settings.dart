import 'package:flutter/material.dart';
import 'package:kampusell/states/_FilterSettingsState.dart';

class FilterSettingsScreen extends StatefulWidget {
  String jwt;

  static FilterSettingsState of(BuildContext context) =>
      context.findAncestorStateOfType();

  FilterSettingsScreen(this.jwt);

  @override
  FilterSettingsState createState() => FilterSettingsState(jwt);
}
