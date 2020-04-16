import 'package:flutter/material.dart';
import 'package:kampusell/states/_FilterSettingsState.dart';

class FilterSettingsScreen extends StatefulWidget {
  static FilterSettingsState of(BuildContext context) =>
      context.findAncestorStateOfType();

  FilterSettingsScreen();

  @override
  FilterSettingsState createState() => FilterSettingsState();
}
